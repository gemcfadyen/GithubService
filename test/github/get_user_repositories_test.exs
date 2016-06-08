defmodule GithubService.Github.GetUserRepositoriesTest do
  use GithubService.ModelCase
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

  @tag :integration
  test "stores repository after it has been retrieved from external api" do
    repositories = GetUserRepositories.execute("hackeryou")

    stored_repos = Storage.find_all_for_user("HackerYou")

    assert length(stored_repos) == 30
  end
end
