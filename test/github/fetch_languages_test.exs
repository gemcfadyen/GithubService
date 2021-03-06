defmodule GithubService.Github.FetchLanguagesTest do
  use GithubService.ModelCase
  alias GithubService.Github.FetchLanguages
  alias GithubService.Github.Storage

  test "gets languages for a given repository from external api" do
    languages = FetchLanguages.for_repository("hackeryou", "amazon")

    assert %{"Ruby" => _byte_count} = languages
  end

  test "languages retrieved through external api are persisted" do
    languages = FetchLanguages.for_repository("hackeryou", "amazon")

    found_languages = Storage.find_all_languages("hackeryou", "amazon")
    assert found_languages == languages
  end

  test "gets language for a repository from local storage" do
    languages = %{"Java" => 0, "CSS" => 0}
    Storage.write_languages("hackeryou", "amazon", languages)
    found_languages = FetchLanguages.for_repository("hackeryou", "amazon")

    assert languages == found_languages
  end
end
