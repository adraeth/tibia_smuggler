# Load the rails application
require File.expand_path('../application', __FILE__)

# Load the app's custom environment variables here, so that they are loaded before environments/*.rb
app_environment_variables = File.join(Rails.root, 'config', 'app_env_variables.rb')
load(app_environment_variables) if File.exists?(app_environment_variables)

# Initialize the rails application
TibiaSmuggler::Application.initialize!
