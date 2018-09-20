module Codacy
  class Git
    def self.commit_id

      commit = ENV['TRAVIS_COMMIT'] ||
          ENV['DRONE_COMMIT'] ||
          ENV['GIT_COMMIT'] ||
          ENV['CIRCLE_SHA1'] ||
          ENV['CI_COMMIT_ID'] ||
          ENV['WERCKER_GIT_COMMIT'] ||
          ENV['HEROKU_TEST_RUN_COMMIT_VERSION'] ||
          ENV['CI_COMMIT_SHA'] ||
          git_commit

      commit
    end

    def self.work_dir
      work_dir = ENV['WORK_DIR'] ||
          ENV['TRAVIS_BUILD_DIR'] ||
          git_dir
      work_dir
    end

    def self.git_commit
      git("log -1 --pretty=format:'%H'")
    end

    def self.git_dir
      dir = `git rev-parse --show-toplevel`
      if $?.to_i == 0
        return dir.strip!
      else
        return ''
      end
    end

    def self.git(command)
      `git --git-dir="#{git_dir}/.git" #{command}`
    end
  end
end
