% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/publishers.R
\name{send.pubresults}
\alias{send.pubresults}
\title{Read in results to publish & Copies results to the project's publication directory}
\usage{
send.pubresults(project.id = get.project())
}
\arguments{
\item{project.id}{Project to publish}
}
\value{
dataframe of files to publish
}
\description{
Read in results to publish & Copies results to the project's publication directory
}
\details{
File is in support directory/files_to_publish.csv
}
\examples{
\dontrun{
send.pubresults("adaprHome")
} 

}
