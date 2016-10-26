#' Make plot of project programs only
#' Summarize all programs.
#' @param project.id Project id of program
#' @return List of data.frame of programs vertices, data.frame of edges, ggplot ,rgrapher=igraph
#' @details Uses ggplot2
#' @export
#'  
 
create_program_graph<- function(project.id){
	
# computes transitively connected subpgraph of project DAG
# given a project id (project.id)
# Uses nicer plot parameters
require(ggplot2)
require(plyr)	

si <- pull_source_info(project.id)

projinfo <- get.project.info.si(si)


outputs <- subset(projinfo$tree,dependency=="out",select=c("source.file","target.path","target.file"))
outputs$fullname <- file.path(outputs$target.path,outputs$target.file)
outputs <- merge(outputs,projinfo$all.files,by="fullname")

unsync.vertex <- c("",as.character(sync.test.si(si)$sources.to.sync$fullname.abbr))

projgraph <- projinfo$graph

sources <- unique(projinfo$tree$source.file)

vertexnames <- subset(projinfo$all.files,file %in%sources)$fullname.abbr

inedges <- adjacent_vertices(projgraph, vertexnames,"out")

inedges <- lapply(inedges,function(x){return(attr(x,"name"))})
inedges <- ldply(inedges,as.data.frame)

names(inedges) <- c("to","from")

dfgraph <- igraph::as_data_frame(projgraph,what="edges")

dfgraph$to <- mapvalues(dfgraph$to,as.character(inedges$from),as.character(inedges$to),warn_missing = FALSE)
dfgraph$from <- mapvalues(dfgraph$from,as.character(inedges$from),as.character(inedges$to),warn_missing = FALSE)

dfoo <- graph_from_data_frame(dfgraph)

#plot(simplify(dfoo))
#dfgraph <- merge(dfgraph,inedges,all.x=TRUE)
#matches <- as.character(inedges[,1])[match(V(projgraph)$name,as.character(inedges[,2]))]
#matches2 <- ifelse(is.na(matches),V(projgraph)$name,matches)
#projgraph2 <- projgraph
#V(projgraph2)$name <- ifelse(is.na(matches),V(projgraph)$name,"")
#graphcontract <- contract(projgraph2,match(matches2,V(projgraph2)$name),vertex.attr.comb = first)

graph2 <- simplify(delete_vertices(dfoo,setdiff(V(dfoo)$name,vertexnames)))


synccolors <- c("aquamarine3","darkorange2")
names(synccolors) <- c("Synchronized", "Not Synchronized")

 
lo <- layout.sugiyama(projgraph)
 
tp <- function(x){
 
  x <- x[,2:1]
 
  x[,1] <- max(x[,1])- x[,1]
 
  return(x)
}
  

longgraph <- NULL

# for(vertex in vertexnames){
# 	
# 	shortgraph <- data.frame(from=vertex,to=vertex)
# 	
# 	tos <- c()
# 	
# 	for(vertexTo in vertexnames){
# 		
# 		shortguy <- shortest_paths(projgraph,vertex,vertexTo)
# 		
# 		if(length(shortguy$vpath[[1]])==3){
# 			
# 			tos <- c(vertexTo,tos)
# 			
# 		}# if one step path
# 
# 		}# loop over targets	
# 			
# 	   if(length(tos)>0){
# 	   	
# 	   	 shortgraph <- rbind(shortgraph,data.frame(from=vertex,to=tos))
# 	   }# if any targets connected
# 		
# 	
# 	longgraph <- rbind(longgraph,shortgraph)
# 	
# } 
# 
#   
# isg <- simplify(graph.data.frame(longgraph))

isg <- graph2
 
#plot(isg) 
 
#plot(isg,layout=tp(layout.sugiyama(isg)$layout))
 
isgdf <- igraph::as_data_frame(isg)

noedges <- 0
  
if(nrow(isgdf)==0){
  
  noedges <- 1
  isgdf <- igraph::as_data_frame(graph.data.frame(data.frame(from=vertexnames[1],to=vertexnames[1])))
  
  
}
 

if(length(vertexnames)==1){
  
  dfo <- data.frame(v=vertexnames[1],x=0,y=0)	
  
  text.nudge0 <- 0.15
  dotsize0 <- 10
  text.size0 <- 10
  
  dfo$synccolor <- as.character(ifelse(dfo$v %in% unsync.vertex,"Not Synchronized","Synchronized"))
  
  dfo$synccolor <- factor(dfo$synccolor,levels=c("Synchronized","Not Synchronized"))
  
  dfo <- merge(dfo,subset(projinfo$all.files,select=c("fullname.abbr","fullname","description")),by.x="v",by.y="fullname.abbr")
  
   froms <- NA
   
   horizontal.range <- c(-1,1)
   rangery <- c(-1,1)*0.5
   graph.height <- 1*0.5
   graph.width <- 1*0.5
   span <- 1
   
}else{

dfo <- tp(layout.sugiyama(isg)$layout)
colnames(dfo) <- c("x","y")
 
dfo <- data.frame(dfo,v=V(isg)$name)
 
todfo <- dfo
names(todfo)[1:2] <- c("x2","y2")

tos <- merge(isgdf,todfo,by.x="to",by.y="v")

froms <- merge(tos,dfo,by.x="from",by.y="v")

ranger <- range(c(froms$x,froms$x2))

span <- 0.1*abs(diff(ranger))

horizontal.range <- c(ranger[1]-span,ranger[2]+span)

rangery <- range(c(froms$y,froms$y2))


graph.height <- length(unique(c(froms$y,froms$y2)))

graph.width <- length(unique(c(froms$y,froms$y2)))



dfo <- merge(dfo,subset(projinfo$all.files,select=c("fullname.abbr","fullname","description")),by.x="v",by.y="fullname.abbr")


}

             
              
dotsize0 <- 10
if(graph.height>5){dot.size <-1+10/graph.height}else{dot.size0 <- 10}              

text.nudge0 <- 0.05*abs(diff(rangery))


text.nudge0 <- dotsize0/20

#if(graph.height>5){text.nudge0 <- 0.05 +text.nudge0/graph.height}              

text.size0 <- 5

if(graph.width>5){text.size0 <-2 + 2*text.size0/graph.width}              

dfo$synccolor <- as.character(ifelse(dfo$v %in% unsync.vertex,"Not Synchronized","Synchronized"))

dfo$synccolor <- factor(dfo$synccolor,levels=c("Synchronized","Not Synchronized"))

proj.gg <- ggplot(dfo,aes(x=x,y=y,label=basename(as.character(v))))+
 geom_point(aes(colour=dfo$synccolor),size=dotsize0,alpha=0.7)+
geom_point(shape = 1,size = dotsize0,colour = "grey70", stroke=2)+
 geom_text(vjust=-0.5,size=text.size0,color="black")

proj.gg <- proj.gg + annotate(geom="label",x=dfo$x,y=dfo$y-ifelse(length(vertexnames)>1,0.125,0.1),label=dfo$description)

if(length(vertexnames)==1){
  
  proj.gg <- proj.gg + scale_y_continuous(limits=rangery)
  
}


if(noedges==0){

proj.gg <- proj.gg+annotate(geom="segment",x=froms$x,y=froms$y,xend=froms$x2,yend=froms$y2,
        arrow=arrow(length=unit(0.2,"cm"),type="closed"),alpha=0.5/ifelse(graph.width>5,5,1))
 
}  
proj.gg <- proj.gg +scale_x_continuous(limits=horizontal.range)+theme(axis.line=element_blank(),axis.text.x=element_blank(),
axis.text.y=element_blank(),axis.ticks=element_blank(),
axis.title.x=element_blank(),
axis.title.y=element_blank(),legend.position="bottom",
panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
panel.grid.minor=element_blank(),plot.background=element_blank())+ggtitle(paste(project.id,"- R Script Graph"))+theme(text=element_text(size=20))

proj.gg <- proj.gg+ scale_color_manual(name = element_blank(), # or name = element_blank()
#labels = c("Synchronized", "Not Synchronized"),
values =synccolors)
isg <- induced_subgraph(projgraph,vertexnames)
runorder <- data.frame(v=topological.sort(isg)$name,run.order=1:length(vertexnames))
dfo <- merge(dfo,runorder,by='v')
            

return(list(vertex=dfo,edges=froms,ggplot=proj.gg,rgrapher=isg))

} #
 
 