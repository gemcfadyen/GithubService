defmodule GithubService.Github.StorageTest do
  use GithubService.ModelCase
  alias GithubService.Github.User
  alias GithubService.Github.Repository
  alias GithubService.Github.Storage

  test "writes a user to the database" do
    %User{login: "hackeryou",
          public_repos: 10,
          repos_url: "repo-url"
    } |> Storage.write_user

    user = Storage.find_user("hackeryou")

    assert user.login == "hackeryou"
    assert user.public_repos == 10
    assert user.repos_url == "repo-url"
  end

  test "writes a repository to the database" do
    %Repository{
      languages_url: "url",
      owner: "hackeryou",
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

    found_languages = Storage.find_all_languages(user, repo_name)

    assert found_languages == languages
  end
end
