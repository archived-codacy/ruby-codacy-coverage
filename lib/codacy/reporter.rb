require 'simplecov'

module Codacy
  module Reporter
    def self.start(profile: nil, partial: false)
      SimpleCov.formatter = partial ? Codacy::PartialFormatter : Codacy::Formatter
      SimpleCov.start(profile)
    end
  end
end
