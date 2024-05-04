#' Transform interaction data from long to wide format
#'
#' @inheritParams plot_web_heatmap
#' @param exclude.noint Logical. Exclude plants/animals with no interactions?
#' Default is TRUE.
#' @param fill.value Value to fill empty cells in the matrix. Default is NA.
#' @param sort Sort matrix rows and columns by frequency?
#'
#' @return A matrix with plants and animals as row and column names, respectively.
#' @export
#' @examples
#' data(web)
#' long2wide(web)
#'

long2wide <- function(df = NULL,
                      plant.var = "Plant",
                      animal.var = "Animal",
                      int.var = "Visits",
                      exclude.noint = TRUE,
                      fill.value = NA,
                      sort = TRUE) {

    df <- df[, c(plant.var, animal.var, int.var)]

    dfwide <- tidyr::pivot_wider(df,
                                 names_from = animal.var,
                                 values_from = int.var,
                                 values_fill = fill.value)

    mat <- as.matrix(dfwide[, -1],
                     dimnames = list(rows = dfwide[[1]],
                                     cols = names(dfwide[, -1])))
    rownames(mat) <- dfwide[[1]]  # because rownames still missing?

    if (isTRUE(exclude.noint)) {
        rows.int <- which(apply(mat, 1, sum, na.rm = TRUE) > 0)
        cols.int <- which(apply(mat, 2, sum, na.rm = TRUE) > 0)
        mat <- mat[rows.int, cols.int]
    }

    if (isTRUE(sort)) {
        mat <- mat[order(rowSums(mat, na.rm = TRUE), decreasing = TRUE),
                   order(colSums(mat, na.rm = TRUE), decreasing = TRUE)]
    }

    mat
}
