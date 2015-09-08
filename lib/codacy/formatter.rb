module Codacy
  class Formatter

    def format(result)
      if should_run?
        parse_result = Codacy::Parser.parse_file(result)
        Codacy::ClientAPI.post_results(parse_result)
      else
        logger.info("Running locally, skipping Codacy coverage")
      end
    rescue => ex
      logger.fatal(ex)
      false
    end

    private

    def should_run?
      ENV["CI"] || ENV["JENKINS_URL"] || ENV['TDDIUM'] || ENV["CODACY_RUN_LOCAL"]
    end

    def logger
      Codacy::Configuration.logger
    end

  end
end
