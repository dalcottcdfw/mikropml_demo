#' Randomize feature order to eliminate any position-dependent effects
#'
#'
#' @inheritParams run_ml
#'
#' @return Dataset with feature order randomized.
#' @export
#' @author Nick Lesniak, \email{nlesniak@@umich.edu}
#' @author Kelly Sovacool, \email{sovacool@@umich.edu}
#'
#' @examples
#' dat <- data.frame(
#'   outcome = c("1", "2", "3"),
#'   a = 4:6, b = 7:9, c = 10:12, d = 13:15
#' )
#' randomize_feature_order(dat, "outcome")
randomize_feature_order <- function(dataset, outcome_colname) {
  features_reordered <- dataset %>%
    split_outcome_features(outcome_colname) %>%
    .[["features"]] %>%
    colnames() %>%
    sample()
  dataset <- dplyr::select(
    dataset,
    dplyr::all_of(outcome_colname),
    dplyr::all_of(features_reordered)
  )
  return(dataset)
}

#' Split dataset into outcome and features
#'
#' @inheritParams run_ml
#'
#' @return list of length two: outcome, features (as dataframes)
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' split_outcome_features(mikropml::otu_mini_bin, "dx")
#' }
split_outcome_features <- function(dataset, outcome_colname) {
  # input validation
  check_dataset(dataset)
  check_outcome_column(dataset, outcome_colname, show_message = FALSE)
  # split outcome and features
  outcome <- dataset %>% dplyr::select(dplyr::all_of(outcome_colname))
  features <- dataset %>% dplyr::select(!dplyr::matches(outcome_colname))
  return(list(outcome = outcome, features = features))
}

#' Use future apply if available
#'
#' @param fun apply function to use (apply, lapply, sapply, etc.)
#'
#' @return output of apply function
#' @keywords internal
#' @author Zena Lapp, \email{zenalapp@@umich.edu}
#'
#' @examples
#' \dontrun{
#' select_apply(fun = "sapply")
#' }
select_apply <- function(fun = "apply") {
  pkg <- "base"
  if (all(check_packages_installed("future.apply"))) {
    fun <- paste0("future_", fun)
    pkg <- "future.apply"
  }
  return(utils::getFromNamespace(fun, pkg))
}

#' Mutate all columns with `utils::type.convert()`.`
#'
#' Turns factors into characters and numerics where possible.
#'
#' @param dat data.frame to convert
#'
#' @return data.frame with no factors
#' @keywords internal
#'
#' @author Kelly Sovacool, \email{sovacool@@umich.edu}
#'
#' @examples
#' \dontrun{
#' dat <- data.frame(
#'   c1 = as.factor(c("a", "b", "c")),
#'   c2 = as.factor(1:3)
#' )
#' class(dat$c1)
#' class(dat$c2)
#' dat <- mutate_all_types(dat)
#' class(dat$c1)
#' class(dat$c2)
#' }
mutate_all_types <- function(dat) {
  return(dat %>% dplyr::mutate_all(utils::type.convert, as.is = TRUE))
}

#' Replace spaces in all elements of a character vector with underscores
#'
#' @param x a character vector
#' @param new_char the character to replace spaces (default: `_`)
#'
#' @return character vector with all spaces replaced with `new_char`
#' @export
#' @author Kelly Sovacool, \email{sovacool@@umich.edu}
#'
#' @examples
#' dat <- data.frame(
#'   dx = c("outcome 1", "outcome 2", "outcome 1"),
#'   a = 1:3, b = c(5, 7, 1)
#' )
#' dat$dx <- replace_spaces(dat$dx)
#' dat
replace_spaces <- function(x, new_char = "_") {
  if (is.character(x)) {
    x <- gsub(" ", new_char, x)
  }
  return(x)
}

#' Update progress if the progress bar is not `NULL`.
#'
#' This allows for flexible code that only initializes a progress bar if the
#' `progressr` package is installed.
#'
#' @param pb a progress bar created with `progressr`.
#' @param message optional message to report (default: `NULL`).
#'
#' @keywords internal
#' @author Kelly Sovacool \email{sovacool@@umich.edu}
#'
#' @examples
#' \dontrun{
#' f <- function() {
#'   if (isTRUE(check_packages_installed("progressr"))) {
#'     pb <- progressr::progressor(steps = 5, message = "looping")
#'   } else {
#'     pb <- NULL
#'   }
#'   for (i in 1:5) {
#'     pbtick(pb)
#'     Sys.sleep(0.5)
#'   }
#' }
#' progressr::with_progress(
#'   f()
#' )
#' }
pbtick <- function(pb, message = NULL) {
  if (!is.null(pb)) {
    if (!is.null(message)) {
      pb(message)
    } else {
      pb()
    }
  }
  invisible()
}

#' Call `sort()` with `method = 'radix'`
#'
#' THE BASE SORT FUNCTION USES A DIFFERENT METHOD DEPENDING ON YOUR LOCALE.
#' However, the order for the radix method is always stable.
#'
#' see https://stackoverflow.com/questions/42272119/r-cmd-check-fails-devtoolstest-works-fine
#'
#' `stringr::str_sort()` solves this problem with the `locale` parameter having
#' a default value, but I don't want to add that as another dependency.
#'
#' @param ... All arguments forwarded to `sort()`.
#' @return Whatever you passed in, now in a stable sorted order regardless of your locale.
#' @keywords internal
#' @author Kelly Sovacool \email{sovacool@@umich.edu}
#'
radix_sort <- function(...) {
  return(sort(..., method = "radix"))
}

#' Check whether a numeric vector contains whole numbers.
#'
#' Because `is.integer` checks for the class, _not_ whether the number is an
#' integer in the mathematical sense.
#' This code was copy-pasted from the `is.integer` docs.
#'
#' @param x numeric vector
#' @param tol tolerance (default: `.Machine$double.eps^0.5`)
#'
#' @return logical vector
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' is_whole_number(c(1, 2, 3))
#' is.integer(c(1, 2, 3))
#' is_whole_number(c(1.0, 2.0, 3.0))
#' is_whole_number(1.2)
#' }
is_whole_number <- function(x, tol = .Machine$double.eps^0.5) {
  abs(x - round(x)) < tol
}

#' Calculate the p-value for a permutation test
#'
#' compute Monte Carlo p-value with correction
#' based on formula from Page 158 of 'Bootstrap methods and their application'
#' By Davison & Hinkley 1997
#'
#' @param vctr vector of statistics
#' @param test_stat the test statistic
#'
#' @return the number of observations in `vctr` that are greater than
#'   `test_stat` divided by the number of observations in `vctr`
#'
#' @keywords internal
#' @author Kelly Sovacool \email{sovacool@@umich.edu}
calc_pvalue <- function(vctr, test_stat) {
  return((sum(vctr >= test_stat) + 1) / (length(vctr) + 1))
}
