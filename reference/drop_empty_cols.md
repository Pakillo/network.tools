# Drop empty columns

Remove columns from an interaction matrix where all values are zero.

## Usage

``` r
drop_empty_cols(mat = NULL, na.rm = TRUE)
```

## Arguments

- mat:

  A matrix containing interaction data.

- na.rm:

  Logical. If TRUE, NA values will be ignored for deciding if a column
  should be removed. If FALSE, columns having NA values will never be
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
drop_empty_cols(mat)
#>      [,1] [,2]
#> [1,]    0    0
#> [2,]    1    1
#> [3,]    0    0
drop_empty_cols(mat, na.rm = FALSE)
#>      [,1] [,2] [,3]
#> [1,]    0    0    0
#> [2,]    1    1    0
#> [3,]    0    0   NA
```
