require 'pry'
require 'yaml'

require 'forking'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end
