defmodule GithubService.Github.FetchUser do
  alias GithubService.Github.TransformUserResponse
  alias GithubService.Github.Storage

  @client Application.get_env(:github_service, :client)

  def with_username(name) do
    user = Storage.find_user(name)
    if user != nil do
      user
    else
      found_user = @client.get_user_with_name(name)
                    |> TransformUserResponse.convert

      Storage.write_user(found_user)
      found_user
    end
  end
end
