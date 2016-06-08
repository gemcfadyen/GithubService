defmodule GithubService.Github.GetUserRepositoriesTest do
  use ExUnit.Case
  alias GithubService.Github.GetUserRepositories
  alias GithubService.Github.Storage
  alias GithubService.Github.Repository
  alias GithubService.Github.Owner

  @tag :integration
  test "invokes client when no existing data is available" do
    repositories = GetUserRepositories.execute("hackeryou")
    assert length(repositories) == 30
  end

  test "retrieves repositories from db if one exists" do
    repository = %Repository{languages_url: "url", owner: %Owner{login: "hackeryou"}, name: "project-name"}
    Storage.write(repository)

    found_repo = GetUserRepositories.execute("hackeryou") |> List.first

    assert found_repo.name == repository.name
    assert found_repo.languages_url == repository.languages_url
    assert found_repo.owner == repository.owner.login
  end
end
