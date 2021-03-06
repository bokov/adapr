% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/git_history_search.R
\name{git.history.search}
\alias{git.history.search}
\title{Performes git history search}
\usage{
git.history.search(gitdir, pattern, branch = NULL, git_args = character(),
  git_binary = NULL)
}
\arguments{
\item{gitdir}{string with git directory}

\item{pattern}{to match in history}

\item{branch}{git branch}

\item{git_args}{arguments to git}

\item{git_binary}{location of git executable}
}
\value{
git log output
}
\description{
Performes git history search
}
\examples{
\dontrun{
 si <- pull_source_info("adaprHome")
 git.history.search(si$project.path,"read_data.R")
} 

}
\author{
Uses git_path adapted form devtools author Hadley Wickham
}
