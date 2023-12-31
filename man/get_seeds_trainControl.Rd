% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cross_val.R
\name{get_seeds_trainControl}
\alias{get_seeds_trainControl}
\title{Get seeds for \code{caret::trainControl()}}
\usage{
get_seeds_trainControl(hyperparams_list, kfold, cv_times, ncol_train)
}
\arguments{
\item{hyperparams_list}{Named list of lists of hyperparameters.}

\item{kfold}{Fold number for k-fold cross-validation (default: \code{5}).}

\item{cv_times}{Number of cross-validation partitions to create (default: \code{100}).}

\item{ncol_train}{number of columns in training data}
}
\value{
seeds for \code{caret::trainControl()}
}
\description{
Adapted from \href{https://stackoverflow.com/a/32598959}{this Stack Overflow post}
and the \link[caret]{trainControl} documentation.
}
\examples{
\dontrun{
get_seeds_trainControl(
  get_hyperparams_list(otu_small, "glmnet"),
  5, 100, 60
)
}
}
\author{
Kelly Sovacool, \email{sovacool@umich.edu}

Zena Lapp, \email{zenalapp@umich.edu}
}
\keyword{internal}
