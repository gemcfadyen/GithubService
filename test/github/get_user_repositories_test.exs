defmodule GithubService.Github.GetUserRepositoriesTest do
  use GithubService.ModelCase
  alias GithubService.Github.GetUserRepositories
  alias GithubService.Github.Storage
  alias GithubService.Github.Repository

  test "invokes client when no existing data is available" do
    repositories = GetUserRepositories.execute("hackeryou")
    assert length(repositories) == 30
  end

  test "stores repository after it has been retrieved from external api" do
    GetUserRepositories.execute("hackeryou")

    stored_repos = Storage.find_all_for_user("hackeryou")
    assert length(stored_repos) == 30
  end

  test "retrieves repositories from db if one exists" do
    repository = %Repository{languages_url: "url", owner: "hackeryou", name: "project-name"}
    Storage.write_repository(repository)

    found_repo = GetUserRepositories.execute("hackeryou") |> List.first

    assert found_repo.name == repository.name
    assert found_repo.languages_url == repository.languages_url
    assert found_repo.owner == repository.owner
  end
end
