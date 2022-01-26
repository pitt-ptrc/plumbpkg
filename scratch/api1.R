#'
#' @importFrom digest digest
#' @importFrom withr with_seed
#' @importFrom magrittr %>%

random_name <- local({
  adjectives <- readLines("data-raw/pos-adj.txt")
  animals <- readLines("data-raw/animals.txt")

  function(id) {
    id %>%
      # hash
      digest() %>%
      # use subset of hash
      substr(1, 7) %>%
      charToRaw() %>%
      as.integer() %>%
      sum() %>%
      withr::with_seed({
        x <- sample(length(adjectives) * length(animals), 2, replace = TRUE)
        adj <- x[seq_along(x) %% 2 == 1] %% length(adjectives) + 1
        ani <- x[seq_along(x) %% 2 == 0] %% length(animals) + 1
        paste0(adjectives[adj], "_", animals[ani])
      })
  }
})

get_shift <- function(id) {
  id %>%
    # hash
    digest() %>%
    # use subset of hash
    substr(28, 32) %>%
    # get integer
    charToRaw() %>%
    as.integer() %>%
    sum() %>%
    # set seed, get shift
    withr::with_seed(sample(1:365, size = 1))
}

get_hash <- function(id) {
  id %>%
    # hash
    digest() %>%
    # use subset of hash
    substr(1, 7)
}


# hello <- function() {
#   "Hello, world!"
# }
#
# echo <- function(msg) {
#   list(msg = paste0("The message is: ", msg))
# }
#
# n_plot <- function(n) {
#   n <- as.numeric(n)
#   if (n > 1e6) stop("n must be less than or equal to 1e6", call. = FALSE)
#   graphics::hist(stats::rnorm(n))
# }
#
# add <- function(x, y) {
#   x <- as.numeric(x)
#   y <- as.numeric(y)
#   if (is.na(x) | is.na(y)) stop("Invalid input", call. = FALSE)
#   x + y
# }

#' Run API 1
#'
#' @param ... Options passed to \code{plumber::plumb()$run()}
#' @examples
#' \dontrun{
#' run_api1()
#' run_api1(swagger = TRUE, port = 8000)
#' }
#' @return A running Plumber API
#' @export
run_api1 <- function(...) {
  plumber::plumb(dir = system.file("plumber", "api1", package = "plumbpkg"))$run(...)
}
