defmodule GithubService.Github.StorageTest do
  use GithubService.ModelCase
  alias GithubService.Github.Repository
  alias GithubService.Github.Owner
  alias GithubService.Github.Storage

  test "writes a repository to the database" do
   %Repository{
      languages_url: "url",
      owner: %Owner{login: "hackeryou"},
      name: "project-name"
    } |> Storage.write_repository

    repo = Storage.find_all_for_user("hackeryou")
           |> List.first

    assert repo.languages_url == "url"
    assert repo.name == "project-name"
    assert repo.owner == "hackeryou"
  end

  test "writes languages to the database" do
    byte_count = 0
    languages = %{"Ruby" => byte_count, "CSS" => byte_count}
    user  = "username"
    repo_name = "repo_name"

    Storage.write_languages(user, repo_name, languages)

    language = Storage.find_all_languages(user, repo_name) |> List.first

    assert language.language
    assert language.byte_count == byte_count
    assert language.user == user
    assert language.repository == repo_name
  end
end
