defmodule GithubService.Github.TransformLanguagesResponse do
  def convert(response) do
     Poison.Parser.parse!(~s(#{response}))
  end
end
