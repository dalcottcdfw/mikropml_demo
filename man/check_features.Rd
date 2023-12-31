% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checks.R
\name{check_features}
\alias{check_features}
\title{Check features}
\usage{
check_features(features, check_missing = TRUE)
}
\arguments{
\item{features}{features for machine learning}

\item{check_missing}{check whether the features have missing data (default: TRUE)}
}
\description{
Check features
}
\examples{
\dontrun{
check_features(otu_mini_bin[, 2:11])
}
}
\author{
Zena Lapp, \email{zenalapp@umich.edu}
}
\keyword{internal}
