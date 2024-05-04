
#' Expand interaction dataset to include zeroes (unobserved interactions)
#'
#' @inheritParams plot_web_heatmap
#' @param fill.value Value to use in `int.var` for unobserved interactions.
#'
#' @return A data frame
#' @export
#' @examples
#' data(web)
#' df <- web[sample(1:nrow(web), size = 30), ]
#' df.expand <- expand_unobs(df)

expand_unobs <- function(df = NULL,
                          plant.var = "Plant",
                          animal.var = "Animal",
                          int.var = "Visits",
                          fill.value = 0) {

    allint <- expand.grid(sort(unique(df[[plant.var]])),
                          sort(unique(df[[animal.var]])),
                          stringsAsFactors = FALSE)

    names(allint) <- c(plant.var, animal.var)

    allint <- dplyr::left_join(allint, df, by = c(plant.var, animal.var))
    allint[[int.var]] <- ifelse(is.na(allint[[int.var]]), fill.value, allint[[int.var]])

    allint |>
      dplyr::arrange(Plant, Animal)

}

