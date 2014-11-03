module Forking
  class Repository

    attr_accessor :uri

    def initialize(uri)
      @uri = uri
    end

    def repo
      options[:repo]
    end

    def directory
      @directory ||= uri.split('/').last.gsub(/\.git$/, '')
    end

    def user
      @user ||= uri.split(":").last.split('/').first
    end

    def domain
      @domain ||= uri.split("@").last.split(":").first
    end

    def ssh_user
      @ssh_user ||= uri.split("@").first
    end

  end
end

