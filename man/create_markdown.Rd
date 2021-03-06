% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_markdown.R
\name{create_markdown}
\alias{create_markdown}
\title{Renders and Rmarkdown file}
\usage{
create_markdown(target.file = paste0(get("source_info")$file$file, "md"),
  target.dir = get("source_info")$markdown.dir, style = "html_document",
  description = "Markdown", si, overwrite = FALSE)
}
\arguments{
\item{target.file}{Markdown file to create}

\item{target.dir}{Directory to send target file}

\item{style}{Markdown target style}

\item{description}{Markdown description}

\item{si}{source_info object for tracking}

\item{overwrite}{overwrite existing R markdown?}
}
\value{
File information
}
\description{
Renders and Rmarkdown file
}
\details{
Uses rmarkdown library to access objects in the R script. Will track dependencies for objects used within Rmd file.
}
\examples{
\dontrun{
source_info <- create_source_file_dir("adaprHome","tree_controller.R")
#Create markdown file in markdown directory for tree_controller.R
create_markdown()
} 


}
