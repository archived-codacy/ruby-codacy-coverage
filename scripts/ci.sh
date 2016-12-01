#!/bin/bash --login

set -e

rvm use 1.9.3-p551
ruby -v
bundle install --gemfile Gemfile.ruby-19
bundle exec rspec

rvm use 2.0.0-p648
ruby -v
bundle install
bundle exec rspec

rvm use 2.1.10
ruby -v
bundle install
bundle exec rspec

rvm use 2.2.5
ruby -v
bundle install
bundle exec rspec

rvm use 2.3.1
ruby -v
bundle install
bundle exec rspec
