% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_ml.R
\name{run_ml}
\alias{run_ml}
\title{Run the machine learning pipeline}
\usage{
run_ml(
  dataset,
  method,
  outcome_colname = NULL,
  hyperparameters = NULL,
  find_feature_importance = FALSE,
  calculate_performance = TRUE,
  kfold = 5,
  cv_times = 100,
  cross_val = NULL,
  training_frac = 0.8,
  perf_metric_function = NULL,
  perf_metric_name = NULL,
  groups = NULL,
  group_partitions = NULL,
  corr_thresh = 1,
  seed = NA,
  ...
)
}
\arguments{
\item{dataset}{Data frame with an outcome variable and other columns as features.}

\item{method}{ML method.
Options: \code{c("glmnet", "rf", "rpart2", "svmRadial", "xgbTree")}.
\itemize{
\item glmnet: linear, logistic, or multiclass regression
\item rf: random forest
\item rpart2: decision tree
\item svmRadial: support vector machine
\item xgbTree: xgboost
}}

\item{outcome_colname}{Column name as a string of the outcome variable
(default \code{NULL}; the first column will be chosen automatically).}

\item{hyperparameters}{Dataframe of hyperparameters
(default \code{NULL}; sensible defaults will be chosen automatically).}

\item{find_feature_importance}{Run permutation importance (default: \code{FALSE}).
\code{TRUE} is recommended if you would like to identify features important for
predicting your outcome, but it is resource-intensive.}

\item{calculate_performance}{Whether to calculate performance metrics (default: \code{TRUE}).
You might choose to skip this if you do not perform cross-validation during model training.}

\item{kfold}{Fold number for k-fold cross-validation (default: \code{5}).}

\item{cv_times}{Number of cross-validation partitions to create (default: \code{100}).}

\item{cross_val}{a custom cross-validation scheme from \code{caret::trainControl()}
(default: \code{NULL}, uses \code{kfold} cross validation repeated \code{cv_times}).
\code{kfold} and \code{cv_times} are ignored if the user provides a custom cross-validation scheme.
See the \code{caret::trainControl()} docs for information on how to use it.}

\item{training_frac}{Fraction of data for training set (default: \code{0.8}). Rows
from the dataset will be randomly selected for the training set, and all
remaining rows will be used in the testing set. Alternatively, if you
provide a vector of integers, these will be used as the row indices for the
training set. All remaining rows will be used in the testing set.}

\item{perf_metric_function}{Function to calculate the performance metric to
be used for cross-validation and test performance. Some functions are
provided by caret (see \code{\link[caret:postResample]{caret::defaultSummary()}}).
Defaults: binary classification = \code{twoClassSummary},
multi-class classification = \code{multiClassSummary},
regression = \code{defaultSummary}.}

\item{perf_metric_name}{The column name from the output of the function
provided to perf_metric_function that is to be used as the performance metric.
Defaults: binary classification = \code{"ROC"},
multi-class classification = \code{"logLoss"},
regression = \code{"RMSE"}.}

\item{groups}{Vector of groups to keep together when splitting the data into
train and test sets. If the number of groups in the training set is larger
than \code{kfold}, the groups will also be kept together for cross-validation.
Length matches the number of rows in the dataset (default: \code{NULL}).}

\item{group_partitions}{Specify how to assign \code{groups} to the training and
testing partitions (default: \code{NULL}). If \code{groups} specifies that some
samples belong to group \code{"A"} and some belong to group \code{"B"}, then setting
\code{group_partitions = list(train = c("A", "B"), test = c("B"))} will result
in all samples from group \code{"A"} being placed in the training set, some
samples from \code{"B"} also in the training set, and the remaining samples from
\code{"B"} in the testing set. The partition sizes will be as close to
\code{training_frac} as possible. If the number of groups in the training set is
larger than \code{kfold}, the groups will also be kept together for
cross-validation.}

\item{corr_thresh}{For feature importance, group correlations
above or equal to \code{corr_thresh} (range \code{0} to \code{1}; default: \code{1}).}

\item{seed}{Random seed (default: \code{NA}).
Your results will only be reproducible if you set a seed.}

\item{...}{All additional arguments are passed on to \code{caret::train()}, such as
case weights via the \code{weights} argument or \code{ntree} for \code{rf} models.
See the \code{caret::train()} docs for more details.}
}
\value{
Named list with results:
\itemize{
\item \code{trained_model}: Output of \code{\link[caret:train]{caret::train()}}, including the best model.
\item \code{test_data}: Part of the data that was used for testing.
\item \code{performance}: Data frame of performance metrics. The first column is the
cross-validation performance metric, and the last two columns are the ML
method used and the seed (if one was set), respectively.
All other columns are performance metrics calculated on the test data.
This contains only one row, so you can easily combine performance
data frames from multiple calls to \code{run_ml()}
(see \code{vignette("parallel")}).
\item \code{feature_importance}: If feature importances were calculated, a data frame
where each row is a feature or correlated group. The columns are the
performance metric of the permuted data, the difference between the true
performance metric and the performance metric of the permuted data
(true - permuted), the feature name, the ML method,
the performance metric name, and the seed (if provided).
For AUC and RMSE, the higher perf_metric_diff is, the more important that
feature is for predicting the outcome. For log loss, the lower
perf_metric_diff is, the more important that feature is for
predicting the outcome.
}
}
\description{
This function splits the data set into a train & test set,
trains machine learning (ML) models using k-fold cross-validation,
evaluates the best model on the held-out test set,
and optionally calculates feature importance using the framework
outlined in Topçuoğlu \emph{et al.} 2020 (\doi{10.1128/mBio.00434-20}).
Required inputs are a data frame (must contain an outcome variable and all
other columns as features) and the ML method.
See \code{vignette('introduction')} for more details.
}
\section{More details}{


For more details, please see
\href{http://www.schlosslab.org/mikropml/articles/}{the vignettes}.
}

\examples{
\dontrun{

# regression
run_ml(otu_small, "glmnet",
  seed = 2019
)

# random forest w/ feature importance
run_ml(otu_small, "rf",
  outcome_colname = "dx",
  find_feature_importance = TRUE
)

# custom cross validation & hyperparameters
run_ml(otu_mini_bin[, 2:11],
  "glmnet",
  outcome_colname = "Otu00001",
  seed = 2019,
  hyperparameters = list(lambda = c(1e-04), alpha = 0),
  cross_val = caret::trainControl(method = "none"),
  calculate_performance = FALSE
)
}
}
\author{
Begüm Topçuoğlu, \email{topcuoglu.begum@gmail.com}

Zena Lapp, \email{zenalapp@umich.edu}

Kelly Sovacool, \email{sovacool@umich.edu}
}
