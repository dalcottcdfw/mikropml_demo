% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checks.R
\name{check_dataset}
\alias{check_dataset}
\title{Check that the dataset is not empty and has more than 1 column.}
\usage{
check_dataset(dataset)
}
\arguments{
\item{dataset}{Data frame with an outcome variable and other columns as features.}
}
\description{
Errors if there are no rows or fewer than 2 columns.
}
\examples{
\dontrun{
check_dataset(otu_small)
}
}
\author{
Kelly Sovacool, \email{sovacool@umich.edu}
}
\keyword{internal}
