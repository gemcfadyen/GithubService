defmodule GithubService.Github.FetchUserTest do
  use GithubService.ModelCase
  alias GithubService.Github.FetchUser
  alias GithubService.Github.User
  alias GithubService.Github.Storage

  @tag :integration
  test "retrieves user information with uppercase name" do
    user = FetchUser.with_username("HackerYou")
    assert user.owner == "hackeryou"
  end

  @tag :integration
  test "retrieves user information externally" do
    user = FetchUser.with_username("hackeryou")

    assert user.owner == "hackeryou"
  end

  @tag :integration
  test "stores user when it is fetched externally" do
    FetchUser.with_username("HackerYou")

    found_user = Storage.find_user("hackeryou")

    assert found_user.owner == "hackeryou"
  end

  test "retrieves user information locally" do
    user = %User{owner: "hackeryou", public_repos: 12, repos_url: "repo-url" }
    Storage.write_user(user)

    found_user = FetchUser.with_username("hackeryou")

    assert found_user.owner == user.owner
  end
end
