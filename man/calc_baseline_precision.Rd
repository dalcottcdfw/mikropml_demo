% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/performance.R
\name{calc_baseline_precision}
\alias{calc_baseline_precision}
\title{Calculate the fraction of positives, i.e. baseline precision for a PRC curve}
\usage{
calc_baseline_precision(dataset, outcome_colname = NULL, pos_outcome = NULL)
}
\arguments{
\item{dataset}{Data frame with an outcome variable and other columns as features.}

\item{outcome_colname}{Column name as a string of the outcome variable
(default \code{NULL}; the first column will be chosen automatically).}

\item{pos_outcome}{the positive outcome from \code{outcome_colname},
e.g. "cancer" for the \code{otu_mini_bin} dataset.}
}
\value{
the baseline precision based on the fraction of positives
}
\description{
Calculate the fraction of positives, i.e. baseline precision for a PRC curve
}
\examples{
# calculate the baseline precision
data.frame(y = c("a", "b", "a", "b")) \%>\%
  calc_baseline_precision(
    outcome_colname = "y",
    pos_outcome = "a"
  )


calc_baseline_precision(otu_mini_bin,
  outcome_colname = "dx",
  pos_outcome = "cancer"
)


# if you're not sure which outcome was used as the 'positive' outcome during
# model training, you can access it from the trained model and pass it along:
calc_baseline_precision(otu_mini_bin,
  outcome_colname = "dx",
  pos_outcome = otu_mini_bin_results_glmnet$trained_model$levels[1]
)

}
\author{
Kelly Sovacool, \email{sovacool@umich.edu}
}
