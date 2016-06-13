defmodule FakeClient do
  @behaviour Client

  def get_repositories_for(_user) do
    File.read!("test/sample_data/repositories_response.json")
  end

  def get_languages_for(_user, _repository) do
    File.read!("test/sample_data/languages_response.json")
  end

  def get_user_with_name(_user) do
    File.read!("test/sample_data/user_response.json")
  end
end
