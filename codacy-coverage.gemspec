lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.authors       = ["Nuno Teixeira", "Rodrigo Fernandes"]
  gem.email         = ["nuno@codacy.com", "rodrigo@codacy.com"]
  gem.description   = "Post code coverage results to Codacy."
  gem.summary       = "Post code coverage results to Codacy."
  gem.homepage      = "https://www.codacy.com"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "codacy-coverage"
  gem.require_paths = ["lib"]
  gem.version       = ENV['PUBLISH_VERSION'] || '1.0.dev'.freeze

  gem.required_ruby_version = '>= 1.9'

  gem.add_runtime_dependency 'simplecov'

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
