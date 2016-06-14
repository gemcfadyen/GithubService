defmodule GithubService.Github.TransformUserResponse do
  alias GithubService.Github.User
  alias GithubService.Github.RemoveUpdatedDate

  def convert(raw_response) do
    raw_response
    |> parse
    |> downcase_user
    |> remove_date
  end

  defp parse(response) do
    Poison.Parser.parse!(response)
  end

  defp downcase_user(user) do
    user_login = Map.get(user, "login")
    %{user | "login" => String.downcase(user_login)}
  end

  defp remove_date(entity) do
    RemoveUpdatedDate.remove_date_from(entity, User)
  end
end
