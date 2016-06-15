defmodule GithubService.Github.TransformUserResponse do
  alias GithubService.Github.User
  alias GithubService.Github.RemoveUpdatedDate

  def convert(raw_response) do
    raw_response
    |> parse
    |> format_owner
    |> remove_date
  end

  defp parse(response) do
    Poison.Parser.parse!(response)
  end

  defp format_owner(parsed_response) do
    parsed_response
    |> Map.get("login")
    |> String.downcase
    |> add_owner(parsed_response)
    |> Map.delete("login")
  end

  defp add_owner(owner_name, parsed_response) do
    parsed_response
    |> Map.put("owner", owner_name)
  end

  defp remove_date(entity) do
    RemoveUpdatedDate.remove_date_from(entity, User)
  end
end
