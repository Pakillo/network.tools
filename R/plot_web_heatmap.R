#' Plot bipartite interaction web as a heatmap
#'
#' @param df A data frame with interaction presence or frequency data
#' @param plant.var character. Name of the column representing plants.
#' @param animal.var character. Name of the column representing animals.
#' @param int.var character. Name of the column representing interaction presence
#' or frequency.
#' @param binarize Logical. Discretize int.var into two categories? (Default is FALSE).
#' @param sort Logical. If TRUE, sort rows and columns by
#' prevalence to show nestedness.
#'
#' @return A ggplot object.
#' @export
#' @import ggplot2
#' @import dplyr
#' @examples
#' data(web)
#' plot_web_heatmap(web)
#' plot_web_heatmap(web, binarize = TRUE)
#' plot_web_heatmap(web, binarize = TRUE, sort = FALSE)
#'
plot_web_heatmap <- function(df,
                             plant.var = "Plant",
                             animal.var = "Animal",
                             int.var = "Visits",
                             binarize = FALSE,
                             sort = TRUE) {

  df$xvar <- df[[animal.var]]
  df$yvar <- df[[plant.var]]
  df$zvar <- df[[int.var]]

  df <- df |>
    group_by(xvar, yvar) |>
    summarise(values = sum(zvar))

  if (isTRUE(binarize)) {
    df <- mutate(df, values = ifelse(values > 0, 1, 0))
  }

  ## Reorder alphabetically

  if (!isTRUE(sort)) {

    df$xvar <- factor(df$xvar, levels = gtools::mixedsort(unique(df$xvar)))
    df$yvar <- factor(df$yvar, levels = rev(gtools::mixedsort(unique(df$yvar))))

  }

  ## Reorder rows by prevalence (to show nestedness)

  if (isTRUE(sort)) {

    ## Sort rows by prevalence
    df2 <- df %>%
      filter(values > 0) %>%
      group_by(xvar) %>%
      summarise(nplants = n()) %>%
      arrange(desc(nplants))
    df$xvar <- factor(df$xvar, levels = df2$xvar)

    ## Arrange columns by prevalence (reverse order for heatmap)
    df3 <- df %>%
      filter(values > 0) %>%
      group_by(yvar) %>%
      summarise(npres = n()) %>%
      arrange(npres)

    df$yvar <- factor(df$yvar, levels = df3$yvar)

  }

  if (isTRUE(binarize)) df <- mutate(df, values = factor(values))

  names(df) <- c(animal.var, plant.var, int.var)


  gg <- ggplot(df, aes(x = df[[animal.var]], y = df[[plant.var]])) +
    geom_tile(aes(x = df[[animal.var]], fill = df[[int.var]])) +
    # scale_fill_viridis() +
    theme(axis.text.x = element_text(angle = 90),
          axis.text = element_text(size = 8)) +
    labs(x = animal.var, y = plant.var, fill = int.var)

  if (isTRUE(binarize)) {
    gg <- gg + scale_fill_manual(values = c("grey30", "grey99")) +
      theme(legend.position = "none")
  }

  gg + coord_equal()

}
