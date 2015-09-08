require 'simplecov'

class InceptionFormatter
  def format(result)
    Codacy::Formatter.new.format(result)
  end
end

SimpleCov.formatter = InceptionFormatter
SimpleCov.start

require 'codacy-coverage'
