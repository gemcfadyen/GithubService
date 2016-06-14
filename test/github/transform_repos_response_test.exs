defmodule GithubService.Github.TransformReposResponseTest do
  use ExUnit.Case
  alias GithubService.Github.TransformReposResponse

  test "transforms client response" do
    repositories = read_sample_data
                    |> TransformReposResponse.convert

    assert length(repositories) == 30
  end

  test "downcases the repository owner name" do
    repository = read_sample_data
    |> TransformReposResponse.convert
    |> List.first

    assert repository.owner == "hackeryou"
  end

  test "repository has the correct fields" do
    repo = read_sample_data
            |> TransformReposResponse.convert
            |> List.first

    assert repo.name == "amazon"
    assert repo.languages_url == "https://api.github.com/repos/HackerYou/amazon/languages"
  end

  defp read_sample_data do
    File.read!("test/sample_data/repositories_response.json")
  end
end
