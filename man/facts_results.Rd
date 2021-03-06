% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/csv.R
\name{facts_results}
\alias{facts_results}
\alias{read_patients}
\alias{read_weeks}
\alias{read_mcmc}
\alias{read_s1_mcmc}
\alias{read_s1_weeks}
\alias{read_s1_patients}
\alias{read_s2_patients}
\alias{read_s2_weeks}
\alias{read_s2_mcmc}
\alias{read_master_mcmc}
\alias{read_master_patients}
\alias{read_master_weeks}
\alias{read_cohorts}
\alias{read_simulations}
\alias{read_csv_special}
\title{Read trial simulation results}
\usage{
read_patients(csv_files)

read_weeks(csv_files)

read_mcmc(csv_files)

read_s1_mcmc(csv_files)

read_s1_weeks(csv_files)

read_s1_patients(csv_files)

read_s2_patients(csv_files)

read_s2_weeks(csv_files)

read_s2_mcmc(csv_files)

read_master_mcmc(csv_files)

read_master_patients(csv_files)

read_master_weeks(csv_files)

read_cohorts(csv_files)

read_simulations(csv_files)

read_csv_special(csv_files, prefix, numbered = TRUE)
}
\arguments{
\item{csv_files}{Character vector of file paths.
Either the directories containing the trial simulation
results or the actual CSV file files themselves.}

\item{prefix}{Character, name of the prefix for \code{read_csv_special()}.
\code{read_weeks(x)} is equivalent to \code{read_csv_special(x, prefix = "weeks")}.
Be careful: not all kinds of CSV output are tested. We can only
guarantee the file types with special functions will be read
correctly, e.g. \code{read_patients()} and \code{read_weeks()}.}

\item{numbered}{Logical. If \code{TRUE},
only read the numbered files like \code{patients00001.csv},
\code{weeks00017.csv}, etc. If \code{FALSE}, only list the non-numbered files
like \code{simulations.csv} and \code{simulations_freq_locf.csv}.
Avoid \code{summary.csv} files. They are not reliable on Linux.}
}
\value{
A data frame of trial simulation data. Each \verb{read_*()} function
returns different information, but all the \verb{read_*()} functions
support the following columns:
\itemize{
\item \code{facts_file}: character, the base name of the FACTS file.
\item \code{facts_scenario}: character, the name of the simulation scenario
from FACTS. Usually, this factors in the virtual subject response
(VSR) profile, accrual profile (how fast do patients enroll?)
and dropout profile (how fast do they drop out?).
\item \code{facts_sim}: integer, numeric index of the CSV file name. For example,
the \code{facts_sim} of \code{patients00012.csv} is \code{12}. In trial execution mode,
all these indices are 00000, so \code{facts_id} is much
safer than \code{facts_sim} for packetized trial execution mode.
\item \code{facts_id}: character, random unique id of each CSV file being read.
Different for every call to \code{read_patients()} etc.
Safer than \code{facts_sim} for aggregation over simulations.
\item \code{facts_output}: character, type of output is in the data frame:
\code{"patients"} for patients files, \code{"weeks"} for weeks files,
\code{"mcmc"} for MCMC files, etc. These names adhere to established
conventions in FACTS.
\item \code{facts_csv}: character, full path to the original CSV files where
FACTS stored the simulation output. Required for \code{\link[=overwrite_csv_files]{overwrite_csv_files()}}.
\item \code{facts_header}: a character vector of \verb{\\n}-delimited CSV file headers.
Required for \code{\link[=overwrite_csv_files]{overwrite_csv_files()}}.
}
}
\description{
These functions read trial simulation results. The results were
computed by FACTS (via \code{\link[=run_facts]{run_facts()}} or \code{\link[=run_engine]{run_engine()}} or
one of the engine functions such as \code{\link[=run_engine_contin]{run_engine_contin()}})
and are stored in CSV files. Different functions read different types
of output. The functions are named according to the CSV files they read.
For example, \code{read_patients()} reads all files named
\code{patients00001.csv}, \code{patients00002.csv}, etc. The most important
functions are \code{read_patients()} and \code{read_weeks()}.
The \verb{read_s1*()}, \verb{read_s2*()}, and \verb{read_master*()} functions
are for staged designs. The \code{read_csv_special()} function allows you to
supply a custom file name prefix such as "patients",
but be warned: not every kind of CSV output file is tested in \code{rfacts}.
}
\examples{
# Can only run if system dependencies are configured:
if (file.exists(Sys.getenv("RFACTS_PATHS"))) {
facts_file <- get_facts_file_example("contin.facts")
out <- run_facts(
  facts_file,
  n_sims = 4,
  verbose = FALSE
)
# What results files do we have?
head(get_csv_files(out))
# Read all the "patients*.csv" files with `read_patients(out)`.
# For each scenario, we have files named
# patients00001.csv, patients00002.csv, patients00003.csv,
# and patients00004.csv.
read_patients(out)
}
}
\seealso{
\code{\link[=get_facts_file_example]{get_facts_file_example()}}, \code{\link[=run_facts]{run_facts()}}, \code{\link[=run_flfll]{run_flfll()}},
\code{\link[=run_engine]{run_engine()}}
}
