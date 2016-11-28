require "octokit"
require "git"
require "yaml"
require "pr_description/version"

module PrDescription
  class Download
    def initialize(current_branch)
      @config = YAML.load_file("#{Dir.home}/.personal_keys")
      @git = Git.open(".")
      @current_branch = current_branch || @git.current_branch
      @remote_name = @git.remote("origin").url.split(":")[1].split(".git")[0]
    end

    def call
      github = Octokit::Client.new(access_token: @config["GITHUB_TOKEN"])
      organization_name = @remote_name.split("/")[0]
      pull = github.pulls(@remote_name, head: "#{organization_name}:#{@current_branch}").first
      if pull
        puts pull[:title] + "\n\n"
        puts pull[:body]
      else
        puts "pull request not found"
      end
    end
  end
end
