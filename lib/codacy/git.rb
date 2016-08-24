module Codacy
  class Git
    def self.commit_id

      commit = ENV['TRAVIS_COMMIT'] ||
          ENV['DRONE_COMMIT'] ||
          ENV['GIT_COMMIT'] ||
          ENV['CIRCLE_SHA1'] ||
          ENV['CI_COMMIT_ID'] ||
          ENV['WERCKER_GIT_COMMIT'] ||
          git_commit

      commit
    end

    def self.work_dir
      work_dir = ENV['WORK_DIR'] || git_dir
      work_dir
    end

    def self.git_commit
      git("log -1 --pretty=format:'%H'")
    end

    def self.git_dir
      return `git rev-parse --show-toplevel`.strip!
    end

    def self.git(command)
      `git --git-dir="#{git_dir}/.git" #{command}`
    end
  end
end
