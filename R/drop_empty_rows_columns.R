#' Drop empty rows
#'
#' Remove rows from an interaction matrix where all values are zero.
#'
#' @param mat A matrix containing interaction data.
#' @param na.rm Logical. If TRUE, NA values will be ignored for deciding if a row
#' should be removed. If FALSE, rows having NA values will never be removed.
#'
#' @return A matrix
#' @export
#'
#' @examples
#' mat <- matrix(c(0,0,0, 1,1,0, 0,0,NA), ncol = 3, byrow = TRUE)
#' mat
#' drop_empty_rows(mat)
#' drop_empty_rows(mat, na.rm = FALSE)
drop_empty_rows <- function(mat = NULL, na.rm = TRUE) {

  empty.rows <- which(rowSums(mat, na.rm = na.rm) == 0)
  if (length(empty.rows) > 0) {
    return(matrix(mat[-empty.rows, ], ncol = ncol(mat)))
  } else {
    return(mat)
  }

}



#' Drop empty columns
#'
#' Remove columns from an interaction matrix where all values are zero.
#'
#' @param mat A matrix containing interaction data.
#' @param na.rm Logical. If TRUE, NA values will be ignored for deciding if a column
#' should be removed. If FALSE, columns having NA values will never be removed.
#'
#' @return A matrix
#' @export
#'
#' @examples
#' mat <- matrix(c(0,0,0, 1,1,0, 0,0,NA), ncol = 3, byrow = TRUE)
#' mat
#' drop_empty_cols(mat)
#' drop_empty_cols(mat, na.rm = FALSE)
drop_empty_cols <- function(mat = NULL, na.rm = TRUE) {

  empty.cols <- which(colSums(mat, na.rm = na.rm) == 0)
  if (length(empty.cols) > 0) {
    return(matrix(mat[, -empty.cols], nrow = nrow(mat)))
  } else {
    return(mat)
  }


}
