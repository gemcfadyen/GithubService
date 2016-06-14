defmodule GithubService.Github.HTTPClientTest do
  use ExUnit.Case
  alias GithubService.Github.HTTPClient

  @tag :integration
  test "gets the user data for a particular username" do
    response = HTTPClient.get_user_with_name("hackeryou")

    assert response =~ "repos_url"
    assert response =~ "login"
    assert response =~ "public_repos"
  end

  @tag :integration
  test "gets the repositories for a user" do
    response = HTTPClient.get_repositories_for("hackeryou")

    assert response =~ "languages_url"
  end

  @tag :integration
  test "gets the languages for a particular repository" do
    response = HTTPClient.get_languages_for("hackeryou", "amazon")

    assert response =~ "Ruby"
    assert response =~ "CSS"
    assert response =~ "JavaScript"
    assert response =~ "CoffeeScript"
  end
end
