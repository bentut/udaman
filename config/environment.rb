# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
UheroDb::Application.initialize!
ENV["DATAFILES_PATH"] = "spec"
ENV["LOAD_UPDATE_SPREADSHEET_PATTERNS_TO_DB"] = "false"
ENV["JON"] = "false"