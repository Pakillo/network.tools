# Niche width and individual specialisation indices

Calculate indices of niche width and individual specialisation,
following Bolnick et al. 2002
([doi:10.1890/0012-9658(2002)083\[2936:MILRS\]2.0.CO;2](https://doi.org/10.1890/0012-9658%282002%29083%5B2936%3AMILRS%5D2.0.CO%3B2)
).

`TNW` calculates the Total Niche Width of the population, using Shannon
diversity.

`WIC` calculates the Within-Individual Component of niche width as a
weighted average of individuals' Shannon diversity (i.e. the Shannon
diversity value of each individual plant is weighted by the proportion
of visits or interactions received by that plant). `WIC` can also return
the individual Shannon diversity values, if `indiv = TRUE`.

`indiv_spec` returns a data.frame with the following columns:

- WIC (Within-Individual Component)

- TNW (Total Niche Width)

- IndSpec (Individual Specialisation index, calculated as the ratio WIC
  / TNW).

## Usage

``` r
indiv_spec(net)

TNW(net)

WIC(net, indiv = FALSE)
```

## Arguments

- net:

  A matrix or data.frame containing interaction data. Plants in rows,
  Animals in columns. Numbers need not be integers (i.e. counts), can be
  relative abundances or interaction frequencies.

- indiv:

  Logical. If TRUE, return individual Shannon diversity values. If
  FALSE, return the weighted average of individual Shannon diversity,
  weighted by the proportion of interactions represented by each plant
  (i.e. the WIC).

## Value

A numeric value or vector for `WIC` and `TNW`, a data.frame in the case
of `indiv_spec`

## Note

Ideally `net` should not contain missing data (NA). If present, they
will be ignored.

## References

Bolnick DI, LH Yang, JA Fordyce, JM Davis, and Svanback R. 2002.
Measuring individual-level resource specialization. Ecology 83:
2936-2941.

## See also

`RInSp::WTdMC()`

## Examples

``` r
data(web)
net <- long2wide(web)

indiv_spec(net)
#>       WIC      TNW   IndSpec
#> 1 1.71828 2.008202 0.8556311
WIC(net)
#>     WIC 
#> 1.71828 
WIC(net, indiv = TRUE)
#> [1] 1.890557 1.504788 1.889159 1.329661
TNW(net)
#>      TNW 
#> 2.008202 
```
