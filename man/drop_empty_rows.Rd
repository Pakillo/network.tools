% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/drop_empty_rows_columns.R
\name{drop_empty_rows}
\alias{drop_empty_rows}
\title{Drop empty rows}
\usage{
drop_empty_rows(mat = NULL, na.rm = TRUE)
}
\arguments{
\item{mat}{A matrix containing interaction data.}

\item{na.rm}{Logical. If TRUE, NA values will be ignored for deciding if a row
should be removed. If FALSE, rows having NA values will never be removed.}
}
\value{
A matrix
}
\description{
Remove rows from an interaction matrix where all values are zero.
}
\examples{
mat <- matrix(c(0,0,0, 1,1,0, 0,0,NA), ncol = 3, byrow = TRUE)
mat
drop_empty_rows(mat)
drop_empty_rows(mat, na.rm = FALSE)
}
