defmodule GithubService.Github.ClientTest do
  use ExUnit.Case
  alias GithubService.Github.Client

  @tag :integration
  test "gets the repositories for a user" do
    response = Client.get_repositories_for("hackeryou")

    assert response =~ "languages_url"
  end

  @tag :integration
  test "gets the languages for a particular repository" do
    response = Client.get_languages_for("hackeryou", "amazon")

    assert response =~ "Ruby"
    assert response =~ "CSS"
    assert response =~ "JavaScript"
    assert response =~ "CoffeeScript"
  end
end
