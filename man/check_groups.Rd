% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checks.R
\name{check_groups}
\alias{check_groups}
\title{Check grouping vector}
\usage{
check_groups(dataset, groups, kfold)
}
\arguments{
\item{dataset}{Data frame with an outcome variable and other columns as features.}

\item{groups}{Vector of groups to keep together when splitting the data into
train and test sets. If the number of groups in the training set is larger
than \code{kfold}, the groups will also be kept together for cross-validation.
Length matches the number of rows in the dataset (default: \code{NULL}).}

\item{kfold}{Fold number for k-fold cross-validation (default: \code{5}).}
}
\description{
Check grouping vector
}
\examples{
\dontrun{
check_groups(mikropml::otu_mini_bin,
  sample(LETTERS, nrow(mikropml::otu_mini_bin), replace = TRUE),
  kfold = 2
)
}
}
\author{
Zena Lapp, \email{zenalapp@umich.edu}
}
\keyword{internal}
