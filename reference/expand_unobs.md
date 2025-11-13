# Expand interaction dataset to include zeroes (unobserved interactions)

Expand interaction dataset to include zeroes (unobserved interactions)

## Usage

``` r
expand_unobs(
  df = NULL,
  plant.var = "Plant",
  animal.var = "Animal",
  int.var = "Visits",
  fill.value = 0
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

- fill.value:

  Value to use in `int.var` for unobserved interactions.

## Value

A data frame

## Examples

``` r
data(web)
df <- web[sample(1:nrow(web), size = 30), ]
df.expand <- expand_unobs(df)
```
