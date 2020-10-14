## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
path <- system.file("example_paths.csv", package = "rfacts")
writeLines(readLines(path))

## ---- echo = FALSE------------------------------------------------------------
old_rfacts_paths <- Sys.getenv("RFACTS_PATHS")
Sys.setenv(
  RFACTS_PATHS = system.file(
    "example_paths.csv",
    package = "rfacts",
    mustWork = TRUE
  )
)

## -----------------------------------------------------------------------------
Sys.getenv("RFACTS_PATHS")

## -----------------------------------------------------------------------------
library(rfacts)
rfacts_paths()

## -----------------------------------------------------------------------------
rfacts_sitrep()

## ---- include = FALSE---------------------------------------------------------
Sys.setenv(RFACTS_PATHS = old_rfacts_paths)
detach("package:rfacts", unload=TRUE)

