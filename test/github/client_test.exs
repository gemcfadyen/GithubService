defmodule GithubService.Github.ClientTest do
  use ExUnit.Case
  alias GithubService.Github.Client

  test "queries for user" do
    response = Client.get_repositories_for("hackeryou")

    assert response =~ "languages_url"
  end
end
