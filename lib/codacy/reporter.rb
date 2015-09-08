require 'simplecov'

module Codacy
  module Reporter
    def start
      SimpleCov.formatter = Codacy::Formatter
      SimpleCov.start
    end
  end
end
