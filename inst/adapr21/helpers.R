git.configure.test <-
  function ()
  {
    
    
    
    config.out <- 99
    try({
      
      git_binary_path <- git_path(NULL)
      config.out  <- system2(git_binary_path, paste("config --global user.name"))
      
    })
    
    return(config.out)
  }


git.configure.test()



temp <- git.configure.test()


get_publication_table <- function(project.id){

  # Retrieves or creates publication table from project.id
  
  source_info <- pull_source_info(project.id)
  publication.file <- file.path(source_info$project.path,project.directory.tree$support,"files_to_publish.csv")
  if(file.exists(publication.file)){
    publication.table <- read.csv(publication.file,as.is=TRUE)
  }else{
    publication.table <- data.frame(Path="",Description="")[-1,]
    write.csv(publication.table,publication.file,row.names=FALSE)
  }  

  return(publication.table)
  
}

fixWindowsDashes <- function(dirname){
  
  return(gsub("\\\\","/",dirname))
  
}

runtimes.source.sync.si <- function(source_info) 
{
  project_info <- get.project.info.si(source_info)
  sync.out <- Sync.test.pi(project_info)
  if (sync.out$synchronized) {
    print(paste("Project synchronized"))
    return(NULL)
  }
  ID.sync.out <- sync.out$sources.to.sync
  if (nrow(ID.sync.out) == 0) {
    warning("There is nothing to run")
  }
  tree.to.run <- subset(project_info$tree, source.file %in% 
                          ID.sync.out$file)
  sync.out <- sync.test.si(source_info)
  propagated.names <- V(sync.out$propagated.graph)$name[V(sync.out$propagated.graph)$synced =="No"]
  
  run.times <- ddply(tree.to.run, "source.file", function(x) {
    last.run.time <- max(as.POSIXct(x$target.mod.time) - as.POSIXct(x$source.run.time), na.rm = TRUE)
    return(data.frame(last.run.time.sec = last.run.time))
  })
  
  return(run.times)
  
}