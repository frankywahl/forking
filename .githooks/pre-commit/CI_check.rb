#!/usr/bin/env ruby
# encoding: utf-8


require 'optparse'
path = File.expand_path("../../../", __FILE__)

Dir.chdir(path)

option_parser = OptionParser.new do |opts|
  opts.on("--about") do
    puts "Run CI test"
    exit 1
  end
end

option_parser.parse!

system("rspec")
exit $?.exitstatus
