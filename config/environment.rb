# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load the app's custom environment variables here, so that they are loaded before environments/*.rb
app_environment_variables = File.join(Rails.root, 'config', 'app_environment_variables.rb')
load(app_environment_variables) if File.exists?(app_environment_variables)

# Initialize the Rails application.
Rails.application.initialize!

Rails.logger = Le.new('583d8a3c-5c1d-4eb1-8db4-17ac7d3631da', :debug => true, :local => true)
