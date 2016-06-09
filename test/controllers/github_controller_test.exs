defmodule GithubService.GithubControllerTest do
  use GithubService.ModelCase
  use GithubService.ConnCase
  alias GithubService.Github.Repository
  alias GithubService.Github.Owner
  alias GithubService.Github.Storage

  @tag :integration
  test "repositories endpoint responds succesfully" do
    conn = conn(:get, "/users/hackeryou/repos")

    response = GithubService.Router.call(conn, [])

    assert response.status == 200
  end

  test "repositories endpoint responds with found repositories in json" do
    repo = %Repository{languages_url: "url", owner: %Owner{login: "hackeryou"}, name: "project-name"}
    Storage.write(repo)
    stored_repos = Storage.find_all_for_user("hackeryou")
    conn = conn(:get, "/users/hackeryou/repos")

    response = GithubService.Router.call(conn, [])

    {:ok, repos_in_json} = Poison.encode(stored_repos)

    assert response.resp_body == repos_in_json
  end

  test "language endpoint responds successfully" do
    conn = conn(:get, "/repos/hackeryou/amazon/languages")

    response = GithubService.Router.call(conn, [])

    assert response.status == 200
  end
end
