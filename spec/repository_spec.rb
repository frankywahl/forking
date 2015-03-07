require_relative 'spec_helper'

describe Forking do
  describe described_class::Repository do
    let(:repo) { described_class.new }

    [:domain, :directory, :user, :ssh_user].each do |method|
      it "responds to #{method}" do
        expect(repo).to respond_to method
      end
    end

    [:domain, :directory, :user].each do |method|
      it "#{method} raise an error"  do
        expect { repo.send(method) }.to raise_error(Forking::Repository::NotImplementedError)
      end
    end
  end

  describe described_class::SSHRepository do
    let(:repo) { described_class.new('git@github.com:frankywahl/forking.git') }

    it 'is a repository' do
      expect(repo).to be_a Forking::Repository
    end

    it '#user' do
      expect(repo.user).to eql 'frankywahl'
    end

    it '#directory' do
      expect(repo.directory).to eql 'forking'
    end

    it '#domain' do
      expect(repo.domain).to eql 'github.com'
    end

    it '#ssh_user' do
      expect(repo.ssh_user).to eql 'git'
    end

    context 'Github enterprise' do
      let(:repo) { described_class.new('git@my.domain.co.uk:frankywahl/forking.git') }

      it '#domain' do
        expect(repo.domain).to eql 'my.domain.co.uk'
      end
    end
  end

  describe described_class::URIRepository do
    let(:repo) { described_class.new('https://github.com/frankywahl/forking.git') }

    it 'is a repository' do
      expect(repo).to be_a Forking::Repository
    end

    it '#user' do
      expect(repo.user).to eql 'frankywahl'
    end

    it '#domain' do
      expect(repo.domain).to eql 'github.com'
    end

    it '#directory' do
      expect(repo.directory).to eql 'forking'
    end

    it '#ssh_user' do
      expect(repo.ssh_user).to be_nil
    end
  end
end
