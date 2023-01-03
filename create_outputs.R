################################################################################
# To build the dashboard, open this file in RStudio, and click the 'Source'
# button (this will run all of the code below). Once it has finished running,
# the complete dashboard can be found in the 'output' folder as an HTML file
# and a ZIP file.
################################################################################

html_output_name <- "Example Dashboard"
code_output_name <- "Example Dashboard - R source code"

# Create output directories if they don't exist
if(!dir.exists("output/data")) {
  dir.create("output/data", recursive = TRUE)
}
if(!dir.exists("output/results")) {
  dir.create("output/results", recursive = TRUE)
}

# Import and clean the raw data
source("scripts/01_clean_data/flights.R", local=new.env())

# Generate summary data for the dashboard pages
source("scripts/02_calculate_summary_data/daily_totals.R", local=new.env())
source("scripts/02_calculate_summary_data/fancy_top_destinations.R", local=new.env())
source("scripts/02_calculate_summary_data/top_destinations.R", local=new.env())

# Render the dashboard to HTML
rmarkdown::render(
  here::here("dashboard.Rmd"),
  output_dir = "output",
  output_file = glue::glue("{html_output_name}.html"),
  envir = new.env()
)
# Create a ZIP archive with the HTML dashboard
zip::zipr(
  zipfile = glue::glue("output/{html_output_name}.zip"),
  files = glue::glue("output/{html_output_name}.html")
)

# Create a ZIP archive with the source code
files <- list.files()
files <- files[!grepl("^output$", files)] # Don't include output folder
zip::zipr(
  zipfile = glue::glue("output/{code_output_name}.zip"),
  files = files
)
