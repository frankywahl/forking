require_relative 'spec_helper'

describe Forking::Repository do
  let(:repo) { described_class.new('git@github.com:frankywahl/forking.git') }

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
end
