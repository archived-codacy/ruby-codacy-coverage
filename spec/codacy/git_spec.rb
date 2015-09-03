require "spec_helper"

describe Codacy::Git do
  describe 'commit hash' do
    it 'recognizes CI environment variable.' do
      expected_git_hash = "123456789"

      original_val = ENV['TRAVIS_COMMIT']
      ENV['TRAVIS_COMMIT'] = expected_git_hash

      result = Codacy::Git.commit_id

      ENV['TRAVIS_COMMIT'] = original_val

      expect(result).to eq expected_git_hash
    end
  end
end
