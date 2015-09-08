require 'simplecov'

module Codacy
  module Reporter
    def self.start
      SimpleCov.formatter = Codacy::Formatter
      SimpleCov.start
    end
  end
end
