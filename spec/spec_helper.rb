require 'simplecov'

class InceptionFormatter
  def format(result)
    ENV["CODACY_RUN_LOCAL"] = 'true'
    Codacy::Formatter.new.format(result)
  end
end

SimpleCov.formatter = InceptionFormatter
SimpleCov.start

require 'codacy-coverage'
