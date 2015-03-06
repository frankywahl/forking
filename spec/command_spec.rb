require 'spec_helper'

describe Forking::Command do
  context 'exists' do
    it 'is true when a command exists' do
      expect(described_class.exists?('which')).to be_truthy
    end

    it 'is false when a command exists' do
      expect(described_class.exists?('not_existing_command')).to be_falsy
    end
  end
end
