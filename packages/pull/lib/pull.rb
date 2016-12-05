require "octokit"
require "git"
require "pull/version"

module Pull
  def self.open(current_branch)
    git = Git.open(".")
    branch = current_branch.empty? ? git.current_branch : current_branch
    remote_name = git.remote("origin").url.split(":")[1].split(".git")[0]
    github = Octokit::Client.new(netrc: true)
    organization_name = remote_name.split("/")[0]
    pull = github.pulls(remote_name, head: "#{organization_name}:#{branch}").first
    exec "open #{pull[:html_url]}"
  end

  def self.to_text(current_branch)
    git = Git.open(".")
    branch = current_branch.empty? ? git.current_branch : current_branch
    remote_name = git.remote("origin").url.split(":")[1].split(".git")[0]
    github = Octokit::Client.new(netrc: true)
    organization_name = remote_name.split("/")[0]
    pull = github.pulls(remote_name, head: "#{organization_name}:#{branch}").first
    if pull
      puts pull[:title] + "\n\n"
      puts pull[:body]
    else
      puts "pull request not found"
    end
  end
end
