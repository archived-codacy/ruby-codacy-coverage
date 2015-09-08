# ruby-codacy-coverage

Ruby coverage reporter for Codacy https://www.codacy.com

[![Build Status](https://circleci.com/gh/codacy/ruby-codacy-coverage.png?style=shield&circle-token=:circle-token)](https://circleci.com/gh/codacy/ruby-codacy-coverage)

Parses SimpleCov output and submits the result to Codacy

## Setup

Include the gem in your project

```
gem 'codacy-coverage', :require => false
```

In the first line of your spec_helper initialize the reporter:

```
require 'codacy-coverage'

Codacy::Reporter.start
```


#### Configuration

To update Codacy, you will need your project API token. You can find the token in Project -> Settings -> Integrations -> Project API.

Then set it in your terminal, replacing %Project_Token% with your own token:

```
export CODACY_PROJECT_TOKEN=%Project_Token%
```

By default this plugin will not submit results if you run your tests in localhost. If you want to force the submission you can setup the following environment variable:

```
export CODACY_RUN_LOCAL=true
```
