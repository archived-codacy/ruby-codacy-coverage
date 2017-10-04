module Codacy
  class Formatter

    def format(result)
      parse_result = Codacy::Parser.parse_file(result)
      Codacy::ClientAPI.post_results(parse_result)
    rescue => ex
      logger.fatal(ex)
      false
    end

    private

    def logger
      Codacy::Configuration.logger
    end

  end
end
