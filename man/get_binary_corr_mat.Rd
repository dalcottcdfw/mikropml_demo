% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/corr_feats.R
\name{get_binary_corr_mat}
\alias{get_binary_corr_mat}
\title{Identify correlated features as a binary matrix}
\usage{
get_binary_corr_mat(
  features,
  corr_thresh = 1,
  group_neg_corr = TRUE,
  corr_method = "spearman"
)
}
\arguments{
\item{features}{a dataframe with each column as a feature for ML}

\item{corr_thresh}{For feature importance, group correlations
above or equal to \code{corr_thresh} (range \code{0} to \code{1}; default: \code{1}).}

\item{group_neg_corr}{Whether to group negatively correlated features
together (e.g. c(0,1) and c(1,0)).}

\item{corr_method}{correlation method. options or the same as those supported
by \code{stats::cor}: spearman, pearson, kendall. (default: spearman)}
}
\value{
A binary matrix of correlated features
}
\description{
Identify correlated features as a binary matrix
}
\examples{
\dontrun{
features <- data.frame(
  a = 1:3, b = 2:4, c = c(1, 0, 1),
  d = (5:7), e = c(5, 1, 4)
)
get_binary_corr_mat(features)
}
}
\author{
Kelly Sovacool, \email{sovacool@umich.edu}
}
\keyword{internal}
