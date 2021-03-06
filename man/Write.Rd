% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Write.R
\name{Write}
\alias{Write}
\title{Write object and capture file information}
\usage{
Write(obj = NULL, file.name = "data.csv", description = "Result file",
  write.fcn = guess.write.fcn(file.name), date = FALSE, ...)
}
\arguments{
\item{obj}{object to write}

\item{file.name}{file to write to the source "Result" directory}

\item{description}{describes object to write}

\item{write.fcn}{function for writing file of object type}

\item{date}{logical for adding date to filename}

\item{...}{arguments passed to write.fcn}
}
\value{
File information list
}
\description{
Write object and capture file information
}
\examples{
\dontrun{
# Within an R script:
source_info <- create_source_file_dir("adaprHome","tree_controller.R")
# Inside R script body:
write.csv(cars,file.path(source_info$results.dir,"test.csv"))
Write(cars,"cars.csv","cars dataframe")
# To examine effect:
showResults()  
} 

}
