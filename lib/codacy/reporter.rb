require 'simplecov'

module Codacy
  module Reporter
    def self.start(profile = nil)
      SimpleCov.formatter = Codacy::Formatter
      SimpleCov.start(profile)
    end
  end
end
