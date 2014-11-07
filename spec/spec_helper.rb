begin
  require 'pry'
rescue LoadError
  puts "Pry is not availble"
end

require 'yaml'

require 'forking'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end
