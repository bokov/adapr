% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_Program.R
\name{remove.program}
\alias{remove.program}
\title{Remove an R script from a project. Removes program, dependency, and results.}
\usage{
remove.program(project.id = get.project(),
  source.file = get("source_info")$file$file, ask = TRUE)
}
\arguments{
\item{project.id}{project id}

\item{source.file}{R script within that project}

\item{ask}{is a logical whether to ask user}
}
\value{
value from file.remove
}
\description{
Remove an R script from a project. Removes program, dependency, and results.
}
\details{
Cannot be undone through adapr! Will not remove markdown or other program side-effects.
}
\examples{
\dontrun{
remove.program("adaprHome","read_data.R")
} 

}
