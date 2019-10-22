require 'simplecov'

module Codacy
  module Reporter
    def self.start(profile = nil, partial = true)
      SimpleCov.formatter = partial ? Codacy::Formatter::Partial : Codacy::Formatter
      SimpleCov.start(profile)
    end
  end
end
