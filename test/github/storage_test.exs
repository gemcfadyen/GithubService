defmodule GithubService.Github.StorageTest do
  use ExUnit.Case
  alias GithubService.Github.Repository
  alias GithubService.Github.Owner
  alias GithubService.Github.Storage

  test "writes a record to database" do
    Storage.write(%Repository{languages_url: "url", owner: %Owner{login: "hackeryou"}, name: "project-name"})

    repo = Storage.find_all_for_user("hackeryou")
            |> List.first

    assert repo.languages_url == "url"
    assert repo.name == "project-name"
    assert repo.owner == "hackeryou"
  end
end
