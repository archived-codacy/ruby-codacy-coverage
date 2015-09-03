require "thor"

module Codacy
  class CommandLine < Thor

    desc "push", "Push coverage information to Codacy"
    def push
      logger.info("Pushing coverage")
      puts Codacy::Git.commit_id
    end

    desc "version", "Reporter version"
    def version
      logger.info("Requesting version")
      puts Codacy::VERSION
    end

    private

    def logger
      Codacy::Configuration::logger
    end

  end
end
