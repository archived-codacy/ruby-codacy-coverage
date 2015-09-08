require 'logger'
require 'tmpdir'

module Codacy
  module Configuration

    def self.logger
      log_filename = self.temp_dir + 'codacy-coverage_' + Date.today.to_s + '.log'
      log_file = File.open(log_filename, 'a')

      logger_file = Logger.new(log_file)
      logger_file.level = Logger::DEBUG

      logger_stdout = Logger.new(STDOUT)
      logger_stdout.level = Logger::INFO

      log = MultiLogger.new(logger_stdout, logger_file)

      log
    end

    def self.temp_dir
      directory_name = Dir.tmpdir + "/codacy-coverage/"
      Dir.mkdir(directory_name) unless File.exists?(directory_name)
      directory_name
    end

    class MultiLogger
      def initialize(*targets)
        @targets = targets
      end

      %w(log debug info warn error fatal unknown).each do |m|
        define_method(m) do |*args|
          @targets.map { |t| t.send(m, *args) }
        end
      end
    end
  end
end
