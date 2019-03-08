defmodule GH.Git do
  def local_repo do
    Git.new(".")
  end

  def current_branch(repo) do
    Git.rev_parse!(repo, ["--abbrev-ref", "HEAD"])
    |> String.trim
  end

  def owner(repo) do
    project(repo)
    |> String.split("/")
    |> List.first
  end

  def repo_name(repo) do
    project(repo)
    |> String.split("/")
    |> List.last
  end

  defp project(repo) do
    Git.config!(repo, ["--get", "remote.origin.url"])
    |> String.trim
    |> String.split(":")
    |> List.last
    |> String.split(".git")
    |> List.first
  end
end
