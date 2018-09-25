require 'json'
require 'uri'
require 'net/https'
require 'codacy/git'

module Codacy
  module ClientAPI
    def self.post_results(parsed_result, partial: false)
      logger.info('Preparing payload...')
      logger.debug(parsed_result)

      project_token, codacy_base_api, commit = get_parameters
      url = create_url(codacy_base_api, commit, partial: partial)

      result = parsed_result.to_json

      if project_token.to_s == ''
        logger.error 'Could not find Codacy API token, make sure you have it configured in your environment.'
        false
      elsif commit.to_s == ''
        logger.error 'Could not find the current commit, make sure that you are running inside a git project.'
        false
      else
        logger.info('Posting ' + result.to_s.length.to_s + ' bytes to ' + url)
        response = send_request(url, result, project_token)

        logger.info(response)
        response.to_s.include? 'success'
      end
    end

    def self.send_request(url, content, project_token, redirects = 3)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path)
      http.use_ssl = uri.scheme == "https"
      request["project_token"] = project_token
      request["Content-Type"] = "application/json"
      request.body = content
      response = http.request(request)

      if [301, 302, 307].include? response.code.to_i and redirects > 0
        redirected_url = response.headers[:location]
        send_request(redirected_url, content, project_token, redirects - 1)
      else
        response.body
      end
    end

    def self.logger
      Codacy::Configuration.logger
    end

    def self.create_url(codacy_base_api, commit, final: false, partial: false)
      commit = commit.gsub(/[^[:alnum:]]/, "")
      if final
        codacy_base_api + '/2.0/commit/' + commit + '/coverageFinal'
      else
        query_params = partial ? '?partial=true' : ''
        codacy_base_api + '/2.0/coverage/' + commit + '/ruby' + query_params
      end
    end

    def self.notify_final
      project_token, codacy_base_api, commit = get_parameters
      url = create_url(codacy_base_api, commit, final: true)

      if project_token.to_s == ''
        puts 'Could not find Codacy API token, make sure you have it configured in your environment.'
        false
      elsif commit.to_s == ''
        puts 'Could not find the current commit, make sure that you are running inside a git project.'
        false
      else
        puts 'Posting Coverage Final Notice to ' + url
        response = send_request(url, '{}', project_token)

        puts response
        response.to_s.include? 'success'
      end
    end

    def self.get_parameters
      project_token = ENV['CODACY_PROJECT_TOKEN']
      codacy_base_api = ENV['CODACY_BASE_API_URL'] || 'https://api.codacy.com'
      commit = Codacy::Git.commit_id
      return project_token, codacy_base_api, commit
    end
  end
end
