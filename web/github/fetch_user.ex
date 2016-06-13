defmodule GithubService.Github.FetchUser do
  alias GithubService.Github.TransformUserResponse
  alias GithubService.Github.Storage

  @client Application.get_env(:github_service, :client)

  def with_username(name) do
    user = Storage.find_user(name)

    transform_user(user, found_user?(user))
  end

  defp transform_user(user, true), do: user
  defp transform_user(user, false) do
    found_user = @client.get_user_with_name(user)
                  |> TransformUserResponse.convert
    Storage.write_user(found_user)
    found_user
  end

  defp found_user?(user) do
    user != nil
  end
end
