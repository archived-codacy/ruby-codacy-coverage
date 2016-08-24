require 'logger'
require 'tmpdir'

module Codacy
  module Configuration

    def self.logger
      logger_info = logger_to_stdout
      logger_info.level = Logger::INFO

      logger_debug = ENV["DEBUG_STDOUT"] ? logger_to_stdout : logger_to_file
      logger_debug.level = Logger::DEBUG

      log = MultiLogger.new(logger_info, logger_debug)

      log
    end

    def self.logger_to_stdout
      Logger.new(STDOUT)
    end

    def self.logger_to_file
      log_file_path = self.temp_dir + self.log_file_name
      log_file = File.open(log_file_path, 'a')
      Logger.new(log_file)
    end

    def self.log_file_name
      today = Date.today
      # rails overrides to_s method of Date class
      # https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/date/conversions.rb#L52
      timestamp = today.respond_to?(:to_default_s) ? today.to_default_s : today.to_s
      'codacy-coverage_' + timestamp + '.log'
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
