#' Read the dependcy data from file
#' @param dependency.pointer filename with dependency data
#' @return dependency data.frame
#' @export
#' @details Not for direct use. See Harvest.trees().


read.dependency <- function(dependency.pointer){
  
  # 	A generic function that writes the dependency object to the dependency.pointer location
  
  return(utils::read.table(dependency.pointer,sep="\t",as.is=TRUE,header=TRUE))
  
}
