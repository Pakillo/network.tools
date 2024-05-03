#' Plot bipartite interaction web as a heatmap
#'
#' @param df A data frame with Presence/Absence or Abundance data for species
#' or interactions (e.g. as produced by `expand_allint()`).
#' @param xvar character. Name of the variable to be used for x-axis.
#' @param yvar character. Name of the variable to be used for y-axis.
#' @param zvar character. Name of the variable containing presence/absence
#' or abundance data, to be used to colour the matrix cells.
#' @param binarize Logical. Discretize zvar into two categories? (Default is FALSE).
#' @param nested Logical. If TRUE (the default), sort rows and columns by
#' prevalence to show nestedness.
#'
#' @return A ggplot object.
#' @export
#' @import ggplot2
#' @import dplyr
#' @examples
#' data(web)
#' plot_web_heatmap(web)
#' plot_web_heatmap(binarize = TRUE)
#' plot_web_heatmap(binarize = TRUE, nested = FALSE)
#'
plot_web_heatmap <- function(df,
                             xvar = "Animal",
                             yvar = "Plant",
                             zvar = "Visits",
                             binarize = FALSE,
                             nested = TRUE) {

  df$xvar <- df[[xvar]]
  df$yvar <- df[[yvar]]
  df$zvar <- df[[zvar]]

  df <- df |>
    group_by(xvar, yvar) |>
    summarise(values = sum(zvar))

  if (isTRUE(binarize)) {
    df <- mutate(df, values = ifelse(values > 0, 1, 0))
  }

  ## Reorder alphabetically

  if (!isTRUE(nested)) {

    df$xvar <- factor(df$xvar, levels = gtools::mixedsort(unique(df$xvar)))
    df$yvar <- factor(df$yvar, levels = rev(gtools::mixedsort(unique(df$yvar))))

  }

  ## Reorder rows by prevalence (to show nestedness)

  if (isTRUE(nested)) {

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

  names(df) <- c(xvar, yvar, zvar)


  gg <- ggplot(df, aes(x = df[[xvar]], y = df[[yvar]])) +
    geom_tile(aes(x = df[[xvar]], fill = df[[zvar]])) +
    #scale_fill_viridis() +
    theme(axis.text.x = element_text(angle = 90),
          axis.text = element_text(size = 8)) +
    labs(x = xvar, y = yvar, fill = zvar)

  if (isTRUE(binarize)) {
    gg <- gg + scale_fill_manual(values = c("grey99", "grey30")) +
      theme(legend.position = "none")
  }


  print(gg)
  invisible(gg)

}
