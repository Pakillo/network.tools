#' Transform interaction data from wide to long format
#'
#' @param mat A matrix containing interaction data. Plants in rows, Animals in columns.
#' @param int.name character. Column name for the interaction values.
#'
#' @return A data frame with three columns: "Plant", "Animal", and interaction values.
#' @export
#' @examples
#' data(web)
#' mat <- long2wide(web)
#' mat
#' df <- wide2long(mat)
#' df
#'

wide2long <- function(mat = NULL,
                      int.name = "Visits") {

  mat.df <- as.data.frame(mat)
  mat.df[, ncol(mat.df) + 1] <- rownames(mat)
  names(mat.df)[ncol(mat.df)] <- "Plant"

  df <- mat.df |>
    tidyr::pivot_longer(
      cols = 1:(ncol(mat.df) - 1),
      cols_vary = "fastest",
      names_to = "Animal",
      values_to = int.name)

  df

}
