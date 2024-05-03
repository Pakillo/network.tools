
#' Expand interaction dataset to include zeroes (unobserved interactions)
#'
#' @param df A data frame with interaction presence or frequency data
#' @param plant.var character. Name of the column representing plants.
#' @param animal.var character. Name of the column representing animals.
#' @param int.var character. Name of the column representing interaction presence
#' or frequency.
#' @param value. Value to use in `int.var` for unobserved interactions.
#'
#' @return A data frame
#' @export
#' @import dplyr
#' data(web)
#' df <- web[sample(1:nrow(web), size = 90), ]
#' df.expand <- expand_unobs(df)

expand_unobs <- function(df = NULL,
                          plant.var = "Plant",
                          animal.var = "Animal",
                          int.var = "Visits",
                          value = 0) {

    allint <- expand.grid(sort(unique(df[[plant.var]])),
                          sort(unique(df[[animal.var]])),
                          stringsAsFactors = FALSE)

    names(allint) <- c(plant.var, animal.var)

    allint <- left_join(allint, df, by = c(plant.var, animal.var))
    allint[[int.var]] <- ifelse(is.na(allint[[int.var]]), value, allint[[int.var]])

    allint |>
      arrange(Plant, Animal)

}

