defmodule GithubService.Github.TransformUserResponseTest do
  use ExUnit.Case
  alias GithubService.Github.TransformUserResponse

  test "downcases user login" do
    user = TransformUserResponse.convert(raw_response)

    assert user.login == "hackeryou"
  end

  test "transforms user response" do
    user = TransformUserResponse.convert(raw_response)

    assert user.login == "hackeryou"
    assert user.public_repos == 35
    assert user.repos_url == "https://api.github.com/users/HackerYou/repos"
  end

  defp raw_response do
    {:ok, response} = File.read("test/sample_data/user_response.json")
    response
  end
end
