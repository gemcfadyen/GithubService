defmodule GithubService.Github.FetchLanguages do
  alias GithubService.Github.Client
  alias GithubService.Github.TransformLanguagesResponse
  alias GithubService.Github.Storage

  def for_repository(name, repo) do

   found_languages = Storage.find_all_languages(name, repo)

   if found_languages == %{} do
    Client.get_languages_for(name, repo)
    |> TransformLanguagesResponse.convert
   else
     found_languages
   end
  end
end
