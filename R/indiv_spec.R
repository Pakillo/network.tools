

#' Niche width and individual specialisation indices
#'
#' @description Calculate indices of niche width and individual specialisation,
#' following Bolnick et al. 2002
#' (\doi{doi:10.1890/0012-9658(2002)083[2936:MILRS]2.0.CO;2}).
#'
#' `TNW` calculates the Total Niche Width of the population, using Shannon diversity.
#'
#' `WIC` calculates the Within-Individual Component of niche width
#' as a weighted average of individuals' Shannon diversity
#' (i.e. the Shannon diversity value of each individual plant is weighted by
#' the proportion of visits or interactions received by that plant).
#' `WIC` can also return the individual Shannon diversity values, if `indiv = TRUE`.
#'
#' `indiv_spec` returns a data.frame with the following columns:
#' - WIC (Within-Individual Component)
#' - TNW (Total Niche Width)
#' - IndSpec (Individual Specialisation index, calculated as the ratio WIC / TNW).
#'
#'
#' @param net A matrix or data.frame containing interaction data.
#' Plants in rows, Animals in columns. Numbers need not be integers (i.e. counts),
#' can be relative abundances or interaction frequencies.
#'
#' @return A numeric value or vector for `WIC` and `TNW`,
#' a data.frame in the case of `indiv_spec`
#' @note Ideally `net` should not contain missing data (NA). If present, they will
#' be ignored.
#' @export
#' @seealso [RInSp::WTdMC()]
#' @references Bolnick DI, LH Yang, JA Fordyce, JM Davis, and Svanback R. 2002.
#' Measuring individual-level resource specialization. Ecology 83: 2936-2941.
#'
#' @examples
#' data(web)
#' net <- long2wide(web)
#'
#' indiv_spec(net)
#' WIC(net)
#' WIC(net, indiv = TRUE)
#' TNW(net)

indiv_spec <- function(net) {

  wic <- WIC(net, indiv = FALSE)
  tnw <- TNW(net)
  indspec <- wic / tnw
  data.frame(WIC = wic, TNW = tnw, IndSpec = indspec, row.names = NULL)

}


## TNW

#' @export
#' @rdname indiv_spec

TNW <- function(net) {

  if (any(is.na(net))) {
    warning("There are NA... Ignoring them")
  }

  out <- net |>
    as.data.frame() |>
    # sum interactions for each animal across all plants
    summarise(across(everything(), \(x) sum(x, na.rm = TRUE))) |>
    # calculate total number of interactions
    mutate(plant.sum = rowSums(across(everything()))) |>
    # calculate interaction cell values as proportions from total plant.sum
    mutate(across(!matches("plant.sum"), function(x, y = plant.sum) {x/y})) |>
    select(-plant.sum) |>
    # calculate Shannon diversity
    mutate(across(everything(), x_logx)) |>
    mutate(TNW = -rowSums(across(everything()), na.rm = TRUE)) |>
    pull(TNW)
  names(out) <- "TNW"

  return(out)

}



## WIC

#' @export
#' @rdname indiv_spec
#' @param indiv Logical. If TRUE, return individual Shannon diversity values.
#' If FALSE, return the weighted average of individual Shannon diversity,
#' weighted by the proportion of interactions represented by each plant
#' (i.e. the WIC).

WIC <- function(net, indiv = FALSE) {

  if (any(is.na(net))) {
    warning("There are NA... Ignoring them")
  }

  out <- net |>
    as.data.frame() |>
    rowwise() |>
    # calculate plant.sum (total number of interactions per plant)
    mutate(plant.sum = rowSums(across(everything()), na.rm = TRUE)) |>
    ungroup() |>
    # calculate plant.prop (proportion of interactions for each plant)
    mutate(plant.prop = plant.sum / sum(plant.sum)) |>
    # calculate interaction cell values as proportions from total plant.sum
    mutate(across(!matches("plant.sum|plant.prop"), function(x, y = plant.sum) {x/y})) |>
    # calculate Shannon diversity
    mutate(across(!matches("plant.sum|plant.prop"), x_logx)) |>
    mutate(shannon = -rowSums(across(!matches("plant.sum|plant.prop")), na.rm = TRUE)) |>
    mutate(shannon.prop = plant.prop * shannon)

  if (any(out$shannon == 0)) {
    warning("There are individuals with Shannon diversity values = 0. This could affect the interpretation of the WIC / TNW index of individual specialisation.")
  }

  if (isTRUE(indiv)) {
    out <- out |>
      pull(shannon)

  } else {
    out <- out |>
      summarise(wic = sum(shannon.prop)) |>
      pull(wic)
    names(out) <- "WIC"
  }

  return(out)

}


x_logx <- function(x) {x*log(x)}
