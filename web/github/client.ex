defmodule GithubService.Github.Client do

  def get_repositories_for(user) do
    url = "https://api.github.com/users/#{user}/repos"
    response = HTTPotion.get(url, headers: ["User-Agent": "Github Service App"])
    response.body
  end

end
