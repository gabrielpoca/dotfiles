defmodule GH.PR do
  def description do
    case pull_request() do
      nil -> "There isn't a pull request open for this branch"
      pr -> "#{pr["title"]}\n\n#{pr["body"]}"
    end
  end

  def url do
    pull_request()
    |> Map.get("html_url")
  end

  def pull_request do
    repo = GH.Git.local_repo
    owner = GH.Git.owner(repo)
    repo_name = GH.Git.repo_name(repo)
    Tentacat.Pulls.filter(owner, repo_name, filters(repo, owner), github_client())
    |> List.first
  end

  defp filters(repo, owner) do
    %{head: "#{owner}:#{GH.Git.current_branch(repo)}"}
  end

  def github_client do
    %{"api.github.com" => %{"login" => user, "password" => password}} = Netrc.read
    Tentacat.Client.new(%{user: user, password: password})
  end
end
