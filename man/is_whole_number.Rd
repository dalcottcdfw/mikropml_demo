% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{is_whole_number}
\alias{is_whole_number}
\title{Check whether a numeric vector contains whole numbers.}
\usage{
is_whole_number(x, tol = .Machine$double.eps^0.5)
}
\arguments{
\item{x}{numeric vector}

\item{tol}{tolerance (default: \code{.Machine$double.eps^0.5})}
}
\value{
logical vector
}
\description{
Because \code{is.integer} checks for the class, \emph{not} whether the number is an
integer in the mathematical sense.
This code was copy-pasted from the \code{is.integer} docs.
}
\examples{
\dontrun{
is_whole_number(c(1, 2, 3))
is.integer(c(1, 2, 3))
is_whole_number(c(1.0, 2.0, 3.0))
is_whole_number(1.2)
}
}
\keyword{internal}
