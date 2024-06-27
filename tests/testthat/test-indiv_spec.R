net <- data.frame(frug1 = c(0, 0.1, NA),
                  frug2 = c(0.2, 0.5, NA),
                  frug3 = c(0.1, 0.1, NA)
)

net <- data.frame(frug1 = c(0, 0.1),
                  frug2 = c(0.2, 0.5),
                  frug3 = c(0.1, 0.1)
)

test_that("Individual specialisation values are correct", {

  # each plant has 1 visit from different animals
  net <- data.frame(A1 = c(0, 1), A2 = c(1, 0))

  expect_equal(TNW(net), c(TNW = 0.693147180559945))
  expect_equal(suppressWarnings(WIC(net)), c(WIC = 0))
  expect_equal(suppressWarnings(WIC(net, indiv = TRUE)), c(0, 0))
  expect_equal(suppressWarnings(indiv_spec(net)),
               data.frame(WIC = 0,
                    TNW = 0.693147180559945,
                    IndSpec = 0))
})


test_that("Individual specialisation values are correct", {

  # each plant has 1 visit from same animal
  net <- data.frame(A1 = c(1, 1), A2 = c(0, 0))

  expect_equal(TNW(net), c(TNW = 0))
  expect_equal(suppressWarnings(WIC(net)), c(WIC = 0))
  expect_equal(suppressWarnings(WIC(net, indiv = TRUE)), c(0, 0))
  expect_equal(suppressWarnings(indiv_spec(net)),
               data.frame(WIC = 0,
                          TNW = 0,
                          IndSpec = NaN))
})


test_that("Individual specialisation values are correct", {

  # plant1 has 0 visits, plant2 has 2 visits from 2 different animals
  net <- data.frame(A1 = c(0, 1), A2 = c(0, 1))

  expect_equal(TNW(net), c(TNW = 0.693147180559945))
  expect_equal(suppressWarnings(WIC(net)), c(WIC = 0.693147180559945))
  expect_equal(suppressWarnings(WIC(net, indiv = TRUE)), c(0, 0.693147180559945))
  expect_equal(suppressWarnings(indiv_spec(net)),
               data.frame(WIC = 0.693147180559945,
                    TNW = 0.693147180559945,
                    IndSpec = 1))
})


test_that("Individual specialisation values are correct", {

  net <- data.frame(frug1 = c(0, 0.1, NA),
                    frug2 = c(0.2, 0.5, NA),
                    frug3 = c(0.1, 0.1, NA)
  )

  expect_warning(TNW(net))
  # expect_warning(WIC(net))
  # expect_warning(indiv_spec(net))

  expect_equal(suppressWarnings(TNW(net)), c(TNW = 0.801818552543337))
  expect_equal(suppressWarnings(WIC(net)), c(WIC = 0.748372398610113))
  expect_equal(suppressWarnings(WIC(net, indiv = TRUE)),
               c(0.636514168294813, 0.796311640173813, 0))
  expect_equal(suppressWarnings(indiv_spec(net)),
               data.frame(WIC = 0.748372398610113,
                    TNW = 0.801818552543337,
                    IndSpec = 0.933343829768349))

})



