# ruby-codacy-coverage

Ruby coverage reporter for Codacy https://www.codacy.com

[![Codacy Badge](https://api.codacy.com/project/badge/grade/72a7aaa0e3fd4a8db27607da159d3daa)](https://www.codacy.com/app/Codacy/ruby-codacy-coverage)
[![Codacy Badge](https://api.codacy.com/project/badge/coverage/72a7aaa0e3fd4a8db27607da159d3daa)](https://www.codacy.com/app/Codacy/ruby-codacy-coverage)
[![Build Status](https://circleci.com/gh/codacy/ruby-codacy-coverage.png?style=shield&circle-token=:circle-token)](https://circleci.com/gh/codacy/ruby-codacy-coverage)
[![Gem Version](https://badge.fury.io/rb/codacy-coverage.svg)](https://badge.fury.io/rb/codacy-coverage)

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

**Enterprise**

To send coverage in the enterprise version you should:
```
export CODACY_BASE_API_URL=<Codacy_instance_URL>:16006
```

By default this plugin will not submit results if you run your tests in localhost. If you want to force the submission you can setup the following environment variable:

```
export CODACY_RUN_LOCAL=true
```

> Note: You should keep your API token well **protected**, as it grants owner permissions to your projects.

#### Running Tests

When you run your tests, the plugin will send the coverage info to Codacy.

For example, run the following commands:

```
gem install bundler
bundle install
```

This will install the required dependencies. Then just run the tests:

```
bundle exec rspec
```

By default, the debug info will be logged into a file. If you want the debug info to be printed to stdout you can:

```
export DEBUG_STDOUT=true
```

You can now check your coverage results in the Codacy dashboard of your project.

## Troubleshoot

**Cannot send coverage when using VCR**

```
require 'vcr'
VCR.configure do |config|
  # other config options
  c.allow_http_connections_when_no_cassette = false
  c.ignore_hosts 'api.codacy.com'
end
```

## What is Codacy?

[Codacy](https://www.codacy.com/) is an Automated Code Review Tool that monitors your technical debt, helps you improve your code quality, teaches best practices to your developers, and helps you save time in Code Reviews.

### Among Codacy’s features:

 - Identify new Static Analysis issues
 - Commit and Pull Request Analysis with GitHub, BitBucket/Stash, GitLab (and also direct git repositories)
 - Auto-comments on Commits and Pull Requests
 - Integrations with Slack, HipChat, Jira, YouTrack
 - Track issues in Code Style, Security, Error Proneness, Performance, Unused Code and other categories

Codacy also helps keep track of Code Coverage, Code Duplication, and Code Complexity.

Codacy supports PHP, Python, Ruby, Java, JavaScript, and Scala, among others.

### Free for Open Source

Codacy is free for Open Source projects.
