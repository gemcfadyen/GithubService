defmodule GithubService.Github.TransformReposResponseTest do
  use ExUnit.Case
  alias GithubService.Github.TransformReposResponse

  test "transforms client response" do
    {:ok, file_content} = File.read("test/github/hackeryou_all_repos.json")

    repositories = TransformReposResponse.convert(file_content)

    assert length(repositories) == 30
  end

  test "repository has the correct fields" do
    {:ok, file_content} = File.read("test/github/hackeryou_all_repos.json")

    repo = TransformReposResponse.convert(file_content) |> List.first

    assert repo.name == "amazon"
    assert repo.languages_url == "https://api.github.com/repos/HackerYou/amazon/languages"
  end

  test "repository contains owner information" do
    {:ok, file_content} = File.read("test/github/hackeryou_all_repos.json")

    repo = TransformReposResponse.convert(file_content) |> List.first

    assert repo.owner.login == "HackerYou"
  end
end
