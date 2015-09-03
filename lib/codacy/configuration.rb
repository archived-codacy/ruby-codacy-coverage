require 'logger'

module Codacy
  module Configuration

    def self.logger
      log = Logger.new($stdout)
      log.level = Logger::INFO

      log
    end

  end
end
