# Transform interaction data from long to wide format

Transform interaction data from long to wide format

## Usage

``` r
long2wide(
  df = NULL,
  plant.var = "Plant",
  animal.var = "Animal",
  int.var = "Visits",
  exclude.noint = TRUE,
  fill.value = NA,
  sort = TRUE
)
```

## Arguments

- df:

  A data frame with interaction presence or frequency data

- plant.var:

  character. Name of the column representing plants.

- animal.var:

  character. Name of the column representing animals.

- int.var:

  character. Name of the column representing interaction presence or
  frequency.

- exclude.noint:

  Logical. Exclude plants/animals with no interactions? Default is TRUE.

- fill.value:

  Value to fill empty cells in the matrix. Default is NA.

- sort:

  Sort matrix rows and columns by frequency?

## Value

A matrix with plants and animals as row and column names, respectively.

## Examples

``` r
data(web)
long2wide(web)
#>    A6 A1 A3 A4 A5 A7 A8 A2
#> P3  5  3  3  2  1  1  1  1
#> P2  3  3  2  0  0  1  1  0
#> P4  1  1  1  2  1  1  0  2
#> P1  0  1  0  0  2  1  2  0
```
