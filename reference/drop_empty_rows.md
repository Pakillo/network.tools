# Drop empty rows

Remove rows from an interaction matrix where all values are zero.

## Usage

``` r
drop_empty_rows(mat = NULL, na.rm = TRUE)
```

## Arguments

- mat:

  A matrix containing interaction data.

- na.rm:

  Logical. If TRUE, NA values will be ignored for deciding if a row
  should be removed. If FALSE, rows having NA values will never be
  removed.

## Value

A matrix

## Examples

``` r
mat <- matrix(c(0,0,0, 1,1,0, 0,0,NA), ncol = 3, byrow = TRUE)
mat
#>      [,1] [,2] [,3]
#> [1,]    0    0    0
#> [2,]    1    1    0
#> [3,]    0    0   NA
drop_empty_rows(mat)
#>      [,1] [,2] [,3]
#> [1,]    1    1    0
drop_empty_rows(mat, na.rm = FALSE)
#>      [,1] [,2] [,3]
#> [1,]    1    1    0
#> [2,]    0    0   NA
```
