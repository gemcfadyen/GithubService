defmodule GithubService.Github.TransformLanguagesResponseTest do
  use ExUnit.Case
  alias GithubService.Github.TransformLanguagesResponse

  test "transforms languages response" do
    {:ok, content} = File.read("test/github/languages_response.json")

    languages = TransformLanguagesResponse.convert(content)

    assert Enum.find(languages, fn(x) -> x == "CSS" end)
  end

end
