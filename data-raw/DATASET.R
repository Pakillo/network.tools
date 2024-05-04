## code to prepare `DATASET` dataset goes here

set.seed(4)

np <- 4
na <- 8

web <- data.frame(
  Plant = rep(paste0("P", 1:np), each = na),
  Animal = paste0("A", 1:na),
  Visits = rpois(np*na, 1)
)

usethis::use_data(web, overwrite = TRUE)
