FROM rocker/r-ver:4.1.2
RUN apt-get update && apt-get install -y  libcurl4-openssl-dev libicu-dev libsodium-dev libssl-dev make zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'remotes::install_cran("rlang")'
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("magrittr",upgrade="never", version = "2.0.1")'
RUN Rscript -e 'remotes::install_version("withr",upgrade="never", version = "2.4.3")'
RUN Rscript -e 'remotes::install_version("digest",upgrade="never", version = "0.6.29")'
RUN Rscript -e 'remotes::install_version("callr",upgrade="never", version = "3.7.0")'
RUN Rscript -e 'remotes::install_version("tictoc",upgrade="never", version = "NA")'
RUN Rscript -e 'remotes::install_version("httr",upgrade="never", version = "1.4.2")'
RUN Rscript -e 'remotes::install_version("testthat",upgrade="never", version = "3.1.1")'
RUN Rscript -e 'remotes::install_version("plumber",upgrade="never", version = "1.1.0")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
RUN rm -rf /build_zone
CMD R -e 'library(dockerfiler)'
