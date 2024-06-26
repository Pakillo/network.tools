% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_web_heatmap.R
\name{plot_web_heatmap}
\alias{plot_web_heatmap}
\title{Plot bipartite interaction web as a heatmap}
\usage{
plot_web_heatmap(
  df,
  plant.var = "Plant",
  animal.var = "Animal",
  int.var = "Visits",
  binarize = FALSE,
  sort = TRUE,
  zero.na = TRUE,
  na.colour = "white"
)
}
\arguments{
\item{df}{A data frame with interaction presence or frequency data}

\item{plant.var}{character. Name of the column representing plants.}

\item{animal.var}{character. Name of the column representing animals.}

\item{int.var}{character. Name of the column representing interaction presence
or frequency.}

\item{binarize}{Logical. Discretize int.var into two categories? (Default is FALSE).}

\item{sort}{Logical. If TRUE, sort rows and columns by
prevalence to show nestedness.}

\item{zero.na}{Logical. Show zeros as NA?}

\item{na.colour}{Colour to be used for NA.}
}
\value{
A ggplot object.
}
\description{
Plot bipartite interaction web as a heatmap
}
\examples{
data(web)
plot_web_heatmap(web)
plot_web_heatmap(web, zero.na = FALSE)
plot_web_heatmap(web, sort = FALSE)
plot_web_heatmap(web, binarize = TRUE)

}
