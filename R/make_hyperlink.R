#' Makes HTML hyper link
#' @param files character vector of filenames
#' @param links description of links
#' @return link command vector
#' @details Used in making HTML files
#' @export
#' @examples 
#'\dontrun{
#'  make.hyperlink("myPath","click here to my path")
#'}
make.hyperlink <- function(files,links){
  
  link.command <- rep("",length(files))
  
  for(file.iter in 1:length(files)){
    link.command[file.iter] <- paste0("<a href=\"file:///",files[file.iter],"\">",links[file.iter],"</a>")
    
    
    
  }
  return(link.command)
  
}