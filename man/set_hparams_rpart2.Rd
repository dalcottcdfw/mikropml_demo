% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hyperparameters.R
\name{set_hparams_rpart2}
\alias{set_hparams_rpart2}
\title{Set hyperparameters for decision tree models}
\usage{
set_hparams_rpart2(n_samples)
}
\arguments{
\item{n_samples}{number of samples in the dataset}
}
\value{
named list of hyperparameters
}
\description{
Set hyperparameters for decision tree models
}
\examples{
\dontrun{
set_hparams_rpart2(100)
set_hparams_rpart2(20)
}
}
\author{
Kelly Sovacool, \email{sovacool@umich.edu}
}
\keyword{internal}
