defmodule GithubService.Github.FetchLanguages do
  alias GithubService.Github.TransformLanguagesResponse
  alias GithubService.Github.Storage
  @client Application.get_env(:github_service, :client)

  def for_repository(name, repo) do
    Storage.find_all_languages(name, repo) |> retrieve_languages(name, repo)
  end

  defp retrieve_languages(languages, name, repo) when languages == %{} do
    languages = @client.get_languages_for(name, repo)
                |> TransformLanguagesResponse.convert

    Storage.write_languages(name, repo, languages)

    languages
  end
  defp retrieve_languages(languages, _name, _repo), do: languages
end
