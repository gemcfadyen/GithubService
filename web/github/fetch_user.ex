defmodule GithubService.Github.FetchUser do
  alias GithubService.Github.TransformUserResponse
  alias GithubService.Github.Storage

  @client Application.get_env(:github_service, :client)

  def with_username(name) do
    Storage.find_user(name)
    |> transform_user(name)
  end

  defp transform_user(nil, name) do
    found_user = @client.get_user_with_name(name)
                  |> TransformUserResponse.convert
      Storage.write_user(found_user)
      found_user
  end
  defp transform_user(user, _name), do: user
end
