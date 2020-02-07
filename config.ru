# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

use Rack::Auth::Basic do |username, password|
  username == ENV['basic_account'] && password == ENV['basic_password']
end
