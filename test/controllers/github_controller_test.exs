defmodule GithubService.GithubControllerTest do
  use GithubService.ModelCase
  use GithubService.ConnCase
  alias GithubService.Github.Storage

  test "user endpoint responds successfully" do
    conn = conn(:get, "/users/hackeryou")

    response = GithubService.Router.call(conn, [])

    assert response.status == 200
  end

  test "repositories endpoint responds successfully" do
    conn = conn(:get, "/users/hackeryou/repos")

    response = GithubService.Router.call(conn, [])

    assert response.status == 200
  end

  test "repositories endpoint responds with found repositories in json" do
    conn = conn(:get, "/users/hackeryou/repos")

    response = GithubService.Router.call(conn, [])

    stored_repos = Storage.find_all_for_user("hackeryou")
    {:ok, repos_in_json} = Poison.encode(stored_repos)
    assert response.resp_body == repos_in_json
  end

  test "repository endpoint uneffected by the case of the username" do
    capitalised_username = "HackerYou"
    conn = conn(:get, "/users/#{capitalised_username}/repos")

    response = GithubService.Router.call(conn, [])

    stored_repos = Storage.find_all_for_user("hackeryou")
    {:ok, repos_in_json} = Poison.encode(stored_repos)
    assert response.resp_body == repos_in_json
  end

  test "languages endpoint responds successfully" do
    conn = conn(:get, "/repos/hackeryou/amazon/languages")

    response = GithubService.Router.call(conn, [])

    assert response.status == 200
  end

  test "languages endpoint uneffected by the case of the username" do
    capitalised_username = "HackerYou"
    conn = conn(:get, "/repos/#{capitalised_username}/amazon/languages")

    response = GithubService.Router.call(conn, [])

    stored_languages = Storage.find_all_languages("hackeryou", "amazon")
    {:ok, json_response} = Poison.encode(stored_languages)
    assert response.resp_body == json_response
  end

  test "languages endpoint returns with repo languages in json" do
    conn = conn(:get, "/repos/hackeryou/amazon/languages")

    response = GithubService.Router.call(conn, [])

    stored_languages = Storage.find_all_languages("hackeryou", "amazon")
    {:ok, json_response} = Poison.encode(stored_languages)
    assert response.resp_body == json_response
  end
end
