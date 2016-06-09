defmodule GithubService.Github.TransformLanguagesResponseTest do
  use ExUnit.Case
  alias GithubService.Github.TransformLanguagesResponse

  test "transforms languages response" do
    {:ok, content} = File.read("test/sample_data/languages_response.json")

    assert %{"Ruby" => _byte_count} = TransformLanguagesResponse.convert(content)
  end
end
