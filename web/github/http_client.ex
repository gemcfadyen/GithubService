defmodule GithubService.Github.HTTPClient do
  @behaviour Client
  @root_url "https://api.github.com/"

  def get_repositories_for(user) do
    url = @root_url <> "users/#{user}/repos"
    get(url).body
  end

  def get_languages_for(user, repository) do
    url = @root_url <> "repos/#{user}/#{repository}/languages"
    get(url).body
  end

  defp get(url) do
    HTTPotion.get(url, headers: ["User-Agent": "Github Service App"])
  end
end
