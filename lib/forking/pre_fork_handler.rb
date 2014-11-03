module Forking
  class PreForkHandler

    attr_reader :directory

    def initialize(options = {})
      @directory = options[:directory]
    end

    def run
      check_for_hub_command
      check_if_directory_exists
    end

    private
    def check_for_hub_command
      unless Command.exists?("hub")
        puts "You need to install hub\n $ brew install hub"
        exit 1
      end
    end

    def check_if_directory_exists
      if directory_exists? directory
        puts "Directory #{directory} alreday exists"
        exit 1
      end
    end

    def directory_exists?(directory)
      File.directory? directory
    end
  end
end
