module Forking
  class Repository
    class NotImplementedError < StandardError; end

    def directory
      fail NotImplementedError, "This #{self.class} cannot respond to:"
    end

    def user
      fail NotImplementedError, "This #{self.class} cannot respond to:"
    end

    def domain
      fail NotImplementedError, "This #{self.class} cannot respond to:"
    end

    def ssh_user
      nil
    end
  end

  class SSHRepository < Repository
    attr_accessor :uri

    def initialize(uri)
      @uri = uri
    end

    def directory
      @directory ||= uri.split('/').last.gsub(/\.git$/, '')
    end

    def user
      @user ||= uri.split(':').last.split('/').first
    end

    def domain
      @domain ||= uri.split('@').last.split(':').first
    end

    def ssh_user
      @ssh_user ||= uri.split('@').first
    end
  end

  class URIRepository < Repository
    attr_accessor :uri

    def initialize(uri)
      require 'uri'
      @uri = URI.parse(uri)
    end

    def domain
      uri.host
    end

    def user
      uri.path.split('/')[1]
    end

    def directory
      uri.path.split('/')[2..-1].join('').gsub(/\.git$/, '')
    end
  end
end
