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
    Storage.write_repository(repo)
    stored_repos = Storage.find_all_for_user("hackeryou")
    conn = conn(:get, "/users/hackeryou/repos")

    response = GithubService.Router.call(conn, [])

    {:ok, repos_in_json} = Poison.encode(stored_repos)

    assert response.resp_body == repos_in_json
  end

  test "endpoint uneffected by the case of the username" do
    repo = %Repository{languages_url: "url", owner: %Owner{login: "hackeryou"}, name: "project-name"}
    Storage.write_repository(repo)
    stored_repos = Storage.find_all_for_user("hackeryou")
    conn = conn(:get, "/users/HackerYou/repos")

    response = GithubService.Router.call(conn, [])

    {:ok, repos_in_json} = Poison.encode(stored_repos)

    assert response.resp_body == repos_in_json
  end

  @tag :integration
  test "language endpoint responds successfully" do
    conn = conn(:get, "/repos/hackeryou/amazon/languages")

    response = GithubService.Router.call(conn, [])

    assert response.status == 200
  end

  test "languages endpoint returns with repo languages in json" do
    languages = %{"CSS" => 0, "Ruby" => 0}
    Storage.write_languages("hackeryou", "amazon", languages)
    conn = conn(:get, "/repos/hackeryou/amazon/languages")

    response = GithubService.Router.call(conn, [])
    stored_languages = Storage.find_all_languages("hackeryou", "amazon")
    {:ok, json_response} = Poison.encode(stored_languages)

    assert response.resp_body == json_response
  end
end
