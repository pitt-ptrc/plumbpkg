library(dockerfiler)

my_dock <- dock_from_desc("DESCRIPTION")

my_dock$CMD(r(library(dockerfiler)))

my_dock$add_after(
  cmd = "RUN R -e 'remotes::install_cran(\"rlang\")'",
  after = 3
)

my_dock$write()
