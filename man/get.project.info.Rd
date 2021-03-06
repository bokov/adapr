% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_project_info.R
\name{get.project.info}
\alias{get.project.info}
\title{Acquire all dependencies related to a project,
Generate graph of project dependencies,
Get all file information related to project}
\usage{
get.project.info(dependency.dir)
}
\arguments{
\item{dependency.dir}{is the string location of dependency files}
}
\value{
list with stacked dependency files, graph of dependencies, and condensed file information
}
\description{
Acquire all dependencies related to a project,
Generate graph of project dependencies,
Get all file information related to project
}
\examples{
\dontrun{
projInfo <- get.project.info(pull_source_info("adaprHome")$dependency.dir)
plot(projInfo$graph) 
} 

}
