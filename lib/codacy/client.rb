require 'json'
require 'rest_client'

module Codacy
  module ClientAPI
    def self.post_results(parsed_result)
      logger.info('Preparing payload...')
      logger.debug(parsed_result)

      project_token = ENV['CODACY_PROJECT_TOKEN']
      codacy_base_api = ENV['CODACY_BASE_API_URL'] || 'https://api.codacy.com'
      commit = Codacy::Git.commit_id
      url = codacy_base_api + '/2.0/coverage/' + commit + '/ruby'

      result = parsed_result.to_json

      if project_token.to_s == ''
        logger.error 'Could not find Codacy API token, make sure you have it configured in your environment.'
        false
      elsif commit.to_s == ''
        logger.error 'Could not find the current commit, make sure that you are running inside a git project.'
        false
      else
        logger.info('Posting ' + result.to_s.bytes.length.to_s + ' bytes to ' + url)
        response = send_request(url, result, project_token)

        logger.info(response)
        response.to_s.include? 'success'
      end
    end

    def self.send_request(url, request, project_token, redirects = 3)
      RestClient.post(
          url,
          request,
          'project_token' => project_token,
          :content_type => :json
      ) do |resp, req, result, &block|
        if [301, 302, 307].include? resp.code and redirects > 0
          redirected_url = resp.headers[:location]
          send_request(redirected_url, req, project_token, redirects - 1)
        else
          resp.return!(req, result, &block)
        end
      end
    end

    def self.logger
      Codacy::Configuration.logger
    end
  end
end