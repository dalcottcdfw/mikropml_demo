% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checks.R
\name{check_outcome_column}
\alias{check_outcome_column}
\title{Check that outcome column exists. Pick outcome column if not specified.}
\usage{
check_outcome_column(
  dataset,
  outcome_colname,
  check_values = TRUE,
  show_message = TRUE
)
}
\arguments{
\item{dataset}{Data frame with an outcome variable and other columns as features.}

\item{outcome_colname}{Column name as a string of the outcome variable
(default \code{NULL}; the first column will be chosen automatically).}

\item{check_values}{whether to check the outcome values or just get the column (default:TRUE)}

\item{show_message}{whether to show which column is being used as the output column (default: TRUE)}
}
\value{
outcome colname
}
\description{
Check that outcome column exists. Pick outcome column if not specified.
}
\examples{
\dontrun{
check_outcome_column(otu_small, NULL)
check_outcome_column(otu_small, "dx")
}
}
\author{
Kelly Sovacool, \email{sovacool@umich.edu}
}
\keyword{internal}
