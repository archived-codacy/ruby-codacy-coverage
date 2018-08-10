require "spec_helper"

describe Codacy::ClientAPI do
  describe 'create url' do
      it 'checks if the url is correct.' do
        codacy_base_api = 'https://api.codacy.com'

        expected_commit_uuid = "9a7d25976a11f2a145f8fee7c4e4ad58b621d560"
        expected_url = Codacy::ClientAPI.create_url(codacy_base_api, expected_commit_uuid)
        
        wrong_commit_uuid = "'9a7d25976a11f2a145f8fee7c4e4ad58b621d560'"
        fixed_url = Codacy::ClientAPI.create_url(codacy_base_api, wrong_commit_uuid)
        
        expect(fixed_url).to eq expected_url
    end
  end
end
