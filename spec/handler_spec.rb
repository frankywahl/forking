require 'spec_helper'

describe Forking::Handler do
  let(:repo) { double("repo") }


  let(:branches) {
    %w( origin/master upstream/master upstream/encoding origin/encoding origin/keep )
  }

  before :each do
    allow(YAML).to receive("load_file") {
      {"example.com"=> [
        {
         "protocol"=>"https",
         "user"=>"my_github_user",
         "oauth_token"=>"asuperauthodoken"
        }
      ]}
    }
    allow(repo).to receive_messages({
      uri: "foo@example.com:bar/dir",
      directory: "dir",
      domain: "example.com"
    })
    allow(Dir).to receive(:chdir).with("dir")
  end

  context "standard forking" do

    let(:handler) { Forking::Handler.new(repository: repo) }

    it "works in the right order" do
      expect(handler).to receive(:system).with("git clone -o upstream foo@example.com:bar/dir dir")
      expect(handler).to receive(:system).with("hub fork")
      expect(handler).to receive(:system).with("git remote rename my_github_user origin")
      expect(handler).to receive(:system).with("git remote update")
      expect(handler).to receive(:system).with("git remote prune origin")
      expect(handler).to receive(:system).with("git remote prune upstream")
      expect(handler).to receive(:branches).and_return(branches)
      expect(handler).to receive(:system).with("git push origin :encoding")
      expect(handler).to receive(:system).with("git push origin :keep").never
      expect(handler).to receive(:system).with('git config --add remote.upstream.fetch "+refs/pull/*/head:refs/remotes/upstream/pr/*"')
      expect(handler).to receive(:system).with('git config --add remote.origin.fetch "+refs/pull/*/head:refs/remotes/origin/pr/*"')
      handler.handle
    end
  end

  context "skipping prs" do
    let(:handler) { Forking::Handler.new(repository: repo, download_pull_request: false) }
    it "does not add the prs" do
      expect(handler).to receive(:system).with('git config --add remote.upstream.fetch "+refs/pull/*/head:refs/remotes/upstream/pr/*"').never
      expect(handler).to receive(:system).with('git config --add remote.origin.fetch "+refs/pull/*/head:refs/remotes/origin/pr/*"').never
      handler.handle
    end
  end

  context "indicating a directroy" do
    let(:handler) { Forking::Handler.new(repository: repo, directory: "foo") }

    before(:each) do
      allow(Dir).to receive(:chdir).with("foo")
      allow(handler).to receive(:system)
    end

    it "clone into that directory" do
      expect(handler).to receive(:system).with("git clone -o upstream foo@example.com:bar/dir dir").never
      expect(handler).to receive(:system).with("git clone -o upstream foo@example.com:bar/dir foo").once
      handler.handle
    end
  end

  context "YAML is not working" do

    let(:handler) { Forking::Handler.new(repository: repo) }

    before(:each) do
      allow(YAML).to receive(:load_file) { raise LoadError }
      allow(handler).to receive(:system)
    end

    it "does not raise an error" do
      expect{ handler.handle }.not_to raise_error
    end

    xit "calls grep instead" do
      expect(:handler).to receive("%x".to_sym).with("grep -A 3 example.com")
      handler.handle
    end

  end
end
