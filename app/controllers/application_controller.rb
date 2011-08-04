class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  
  helper :all # include all helpers, all the time
  protect_from_forgery
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password, :password_confirmation
end
