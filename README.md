
<!-- README.md is generated from README.Rmd. Please edit that file -->

# network.tools

<!-- badges: start -->

[![R-CMD-check](https://github.com/Pakillo/network.tools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Pakillo/network.tools/actions/workflows/R-CMD-check.yaml)
[![HitCount](https://hits.dwyl.com/Pakillo/network.tools.svg?style=flat-square)](http://hits.dwyl.com/Pakillo/network.tools)
[![HitCount](https://hits.dwyl.com/Pakillo/network.tools.svg?style=flat-square&show=unique)](http://hits.dwyl.com/Pakillo/network.tools)
<!-- badges: end -->

Tools to work with bipartite networks.

## Installation

You can install the development version of network.tools from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Pakillo/network.tools")
```

## Usage

``` r
library(network.tools)
```

### Visualise bipartite network as heatmap

``` r
data(web)
plot_web_heatmap(web)
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

Binarize the network (make it qualitative):

``` r
plot_web_heatmap(web, binarize = TRUE)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

The output is a ggplot object that can be further modified:

``` r
plot_web_heatmap(web) + viridis::scale_fill_viridis()
#> Scale for fill is already present.
#> Adding another scale for fill, which will replace the existing scale.
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

### Transform interaction data from long to wide format

``` r
long2wide(web)
#>    A6 A1 A3 A4 A5 A7 A8 A2
#> P3  5  3  3  2  1  1  1  1
#> P2  3  3  2  0  0  1  1  0
#> P4  1  1  1  2  1  1  0  2
#> P1  0  1  0  0  2  1  2  0
```

### Transform interaction data from wide to long format

``` r
mat <- long2wide(web)
wide2long(mat)
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
