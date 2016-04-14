#' Captures libraries that are not loaded automatically
#' @param library.data.file CSV File with a set of library names and repository locations
#' @param verbose Print which libraries are installed and loaded
#' @return Libraries loaded that were not automatically loaded
#' @details Captures unaccounted for library within library information file
#' @export
#' 
#' 
id_new_libs <- function(library.data.file){
 
 #library.data.file= "/Users/Gelfond/Documents/Projects/Aflatoxin/Programs/support_functions/common_libs.csv"
 
  packages.info.all <- read.csv(library.data.file,as.is=TRUE)
  
  adapr_packs <- c("adapr","knitr","plyr","rCharts","shinydashboard","devtools","R2HTML","shiny","gplots","digest","igraph","stats",
  					"stats","graphics","grDevices","utils","datasets","methods","base","plotly","shinyIncubator")

   notadapr <- setdiff(loaded_packages()$package,adapr_packs)
   
   missing <- setdiff(notadapr,packages.info.all$Package)   					   					
  
   #Only load nonspecific packages if subgroup is null
  
  if(length(missing)){
    packages.info <- rbind(packages.info.all,data.frame(Package=missing,repos=NA,specific=TRUE))
    write.csv(packages.info,library.data.file,row.names=FALSE)
    
  }    
  
 
  return(missing)	
  
  
}