#' Configure user.name and email for git. Requires git installation.
#' @param user.name Chris Someone
#' @param user.email someone[at]somewhere.com
#' @return output from git
#' @export
#' @examples 
#'\dontrun{
#' # Requires Git installation
#'  git.configure("jonG","gelfond@somewhere.com")
#'} 
#' 
git.configure <- function(user.name,user.email){
  
  
  git2r::config(global=TRUE,user.name,user.email)
  
  #git_binary_path <- git_path(NULL)
  #user.email <- system2(git_binary_path,paste("config --global user.email", shQuote(user.email)))
  #user.name  <- system2(git_binary_path,paste("config --global user.name",  shQuote(user.name)))
  
  return(list(user.email,user.name))
  
}