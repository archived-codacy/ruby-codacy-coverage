require "spec_helper"

describe Codacy::ClientAPI do
  describe 'create url' do
    let(:codacy_base_api) {'https://api.codacy.com'}

    it 'checks if the url is correct.' do
      expected_commit_uuid = "9a7d25976a11f2a145f8fee7c4e4ad58b621d560"
      expected_url = Codacy::ClientAPI.create_url(codacy_base_api, expected_commit_uuid)

      wrong_commit_uuid = "'9a7d25976a11f2a145f8fee7c4e4ad58b621d560'"
      fixed_url = Codacy::ClientAPI.create_url(codacy_base_api, wrong_commit_uuid)

      expect(fixed_url).to eq expected_url
    end

    it 'generates coverage final url' do
      commit_uuid = "9a7d25976a11f2a145f8fee7c4e4ad58b621d560"

      url = Codacy::ClientAPI.create_url(codacy_base_api, commit_uuid, final: true)

      expect(url).to include('coverageFinal')
    end

    it 'generates url with partial query parameter' do
      commit_uuid = "9a7d25976a11f2a145f8fee7c4e4ad58b621d560"

      url = Codacy::ClientAPI.create_url(codacy_base_api, commit_uuid, partial: true)

      expect(url).to include('partial=true')
    end
  end

  describe '.notify_final' do
    context 'missing project token' do
      it 'returns false' do
        ENV['CODACY_PROJECT_TOKEN'] = ''
        expect(Codacy::ClientAPI.notify_final).to be false
      end
    end
  end
end
