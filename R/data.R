#' Small OTU abundance dataset
#'
#' A dataset containing relatives abundances of 60 OTUs for 60 human stool samples.
#' This is a subset of the data provided in `extdata/otu_large.csv`, which was
#' used in [Topçuoğlu _et al._ 2020](https://journals.asm.org/doi/10.1128/mbio.00434-20).
#'
#' @format A data frame with 60 rows and 61 variables.
#' The `dx` column is the diagnosis: healthy or cancerous (colorectal).
#' All other columns are OTU relative abundances.
"otu_small"

#' Mini OTU abundance dataset
#'
#' A dataset containing relatives abundances of OTUs for human stool samples
#' with a binary outcome, `dx`.
#' This is a subset of `otu_small`.
#'
#' @format A data frame
#' The `dx` column is the diagnosis: healthy or cancerous (colorectal).
#' All other columns are OTU relative abundances.
"otu_mini_bin"

#' Mini OTU abundance dataset - preprocessed
#'
#' This is the result of running `preprocess_data("otu_mini_bin")`
"otu_data_preproc"

#' Mini OTU abundance dataset with 3 categorical variables
#'
#' A dataset containing relatives abundances of OTUs for human stool samples
#'
#' @format A data frame
#' The `dx` column is the colorectal cancer diagnosis: adenoma, carcinoma, normal.
#' All other columns are OTU relative abundances.
"otu_mini_multi"

#' Cross validation on `train_data_mini` with grouped features.
"otu_mini_cv"

#' Results from running the pipeline with L2 logistic regression on `otu_mini_bin` with feature importance and grouping
"otu_mini_bin_results_glmnet"

#' Results from running the pipeline with random forest on `otu_mini_bin`
"otu_mini_bin_results_rf"

#' Results from running the pipeline with svmRadial on `otu_mini_bin`
"otu_mini_bin_results_svmRadial"

#' Results from running the pipeline with xbgTree on `otu_mini_bin`
"otu_mini_bin_results_xgbTree"

#' Results from running the pipeline with rpart2 on `otu_mini_bin`
"otu_mini_bin_results_rpart2"

#' Results from running the pipeline with glmnet on `otu_mini_bin` with `Otu00001`
#' as the outcome
"otu_mini_cont_results_glmnet"

#' Results from running the pipeline with glmnet on `otu_mini_bin` with `Otu00001`
#' as the outcome column,
#' using a custom train control scheme that does not perform cross-validation
"otu_mini_cont_results_nocv"

#' Results from running the pipeline with glmnet on `otu_mini_multi` for
#' multiclass outcomes
"otu_mini_multi_results_glmnet"

#' Groups for otu_mini_multi
"otu_mini_multi_group"
