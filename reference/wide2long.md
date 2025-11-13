# Transform interaction data from wide to long format

Transform interaction data from wide to long format

## Usage

``` r
wide2long(mat = NULL, int.name = "Visits")
```

## Arguments

- mat:

  A matrix containing interaction data. Plants in rows, Animals in
  columns.

- int.name:

  character. Column name for the interaction values.

## Value

A data frame with three columns: "Plant", "Animal", and interaction
values.

## Examples

``` r
data(web)
mat <- long2wide(web)
mat
#>    A6 A1 A3 A4 A5 A7 A8 A2
#> P3  5  3  3  2  1  1  1  1
#> P2  3  3  2  0  0  1  1  0
#> P4  1  1  1  2  1  1  0  2
#> P1  0  1  0  0  2  1  2  0
df <- wide2long(mat)
df
#> # A tibble: 32 × 3
#>    Plant Animal Visits
#>    <chr> <chr>   <int>
#>  1 P3    A6          5
#>  2 P3    A1          3
#>  3 P3    A3          3
#>  4 P3    A4          2
#>  5 P3    A5          1
#>  6 P3    A7          1
#>  7 P3    A8          1
#>  8 P3    A2          1
#>  9 P2    A6          3
#> 10 P2    A1          3
#> # ℹ 22 more rows
```
