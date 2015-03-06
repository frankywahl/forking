module Forking
  class Handler
    attr_reader :options, :repo, :directory

    def initialize(options = {})
      @options = options
      @repo = options[:repository]
      @directory = options[:directory] || repo.directory
    end

    def handle
      clone_the_repo
      change_directory
      fork_the_repo
      rename_remotes
      download_pull_requests if download_pull_requests?
      update_remotes
      prune_remotes
      remove_remote_branches
    end

    private

    def clone_the_repo
      system("git clone -o upstream #{repo.uri} #{directory}")
    end

    def change_directory
      Dir.chdir(directory)
    end

    def fork_the_repo
      system('hub fork')
    end

    def rename_remotes
      system("git remote rename #{hub_user} origin")
    end

    def update_remotes
      system('git remote update')
    end

    def prune_remotes
      system('git remote prune origin')
      system('git remote prune upstream')
    end

    def hub_user
      @hub_user ||= begin
         begin
           require 'yaml'
           YAML.load_file("#{ENV['HOME']}/.config/hub")[repo.domain].first['user']
         rescue LoadError
           `grep -A 3 #{repo.domain} ~/.config/hub | grep user: | sed 's/  user: //'`.strip
         end
       end
    end

    def download_pull_requests
      system('git config --add remote.upstream.fetch "+refs/pull/*/head:refs/remotes/upstream/pr/*"')
      system('git config --add remote.origin.fetch "+refs/pull/*/head:refs/remotes/origin/pr/*"')
    end

    def download_pull_requests?
      options.fetch(:download_pull_request, true)
    end

    # Removes all branches that are both on upstream and origin
    def remove_remote_branches
      # remove other people's branches from your github repo
      # keep just the master
      branches.each do |branch|
        next unless branch =~ /upstream/
        next if branch =~ %r{upstream\/pr\/[0-9]*}
        next if branch =~ /master$/
        system("git push origin :#{branch.gsub(/upstream\//, '')}")
      end
    end

    def branches
      IO.popen('git branch -r') do |io|
        text = []
        while (line = io.gets)
          text << line.strip
        end
        text
      end
    end
  end
end
