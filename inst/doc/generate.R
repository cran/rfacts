## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
knitr::opts_knit$set(root.dir = fs::dir_create(tempfile()))
library(dplyr)
library(rfacts)
library(tibble)

## -----------------------------------------------------------------------------
library(dplyr)
library(rfacts)
library(tibble)
tmp <- file.copy(get_facts_file_example("contin.facts"), getwd())
facts_file <- "contin.facts"

## -----------------------------------------------------------------------------
field_subjects <- tibble(
  field = "my_subjects",        # custom name the user can make up
  type = "NucleusParameterSet", # "type" attribute of the <parameterSets> tag
  set = "nucleus",              # "name" attribute of the <parameterSet> tag
  property = "max_subjects"     # "name" attribute of the <property> tag
)

## -----------------------------------------------------------------------------
field_vsr <- tibble(
  field = "my_vsr",                 
  type = "EfficacyParameterSet",      
  set = "resp2",                      
  property = "true_endpoint_response" 
)

## -----------------------------------------------------------------------------
fields <- bind_rows(field_subjects, field_vsr)
fields

## -----------------------------------------------------------------------------
values <- tibble(
  facts_file = facts_file,
  my_subjects = c(1000, 2000),
  my_vsr = list(c(15, 50), c(25, 75))
)
values

## -----------------------------------------------------------------------------
write_facts(fields = fields, values = values)
list.files("_facts")

## -----------------------------------------------------------------------------
unlink("_facts", recursive = TRUE)
values$output <- c("small.facts", "large.facts")
write_facts(fields = fields, values = values)

## -----------------------------------------------------------------------------
read_facts(facts_file = facts_file, fields = fields)

read_facts(facts_file = "small.facts", fields = fields)

read_facts(facts_file = "large.facts", fields = fields)

