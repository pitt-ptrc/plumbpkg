library(tidyverse)
library(digest)

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

df <- tibble(x = runif(100))

df %>%
  rowwise() %>%
  mutate(shift = get_shift(x)) %>%
  mutate(hash = get_hash(x)) %>%
  mutate(display_name = random_name(x))



tibble(x = runif(1000)) %>%
  rowwise() %>%
  mutate(hash = digest(x)) %>%
  mutate(hhash = substr(hash, 20, 32)) %>%
  mutate(randint = c2i(hhash)) %>%
  mutate(dateshift = randint %% 365) %>%
  mutate(dateshift2 = x %>% get_shift()) %>%
  ggplot(aes(dateshift)) +
  geom_histogram(binwidth = 1)

as.integer("d69e7827ff0b1272336c2136df42c3f0")


mtcars %>%
  tibble() %>%
  select(mpg) %>%
  rowwise() %>%
  mutate(hash = digest(mpg)) %>%
  mutate(hhash = substr(hash, 26, 32)) %>%
  mutate(randint = c2i(hhash)) %>%
  mutate(dateshift = randint %% 365) %>%
  mutate(dateshift2 = mpg %>% get_shift()) %>%
  ggplot(aes(dateshift)) +
  geom_histogram(binwidth = 1)

nchar("d69e7827ff0b1272336c2136df42c3f0")


digest::digest2int("alsdf") %% 365
