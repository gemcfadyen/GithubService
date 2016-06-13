defmodule GithubService.Github.TransformUserResponse do
  alias GithubService.Github.User

  def convert(raw_response) do
    Poison.Parser.parse!(raw_response)
    |> downcase_user
    |> convert_keys_to_atoms
    |> remove_updated_at_key
    |> convert_map_to_struct
  end

  defp downcase_user(user) do
   user_login = Map.get(user, "login")
   %{user | "login" => String.downcase(user_login)}
  end

  defp convert_keys_to_atoms(user) do
    for {key, val} <- user, into: %{}, do: {String.to_atom(key), val}
  end

  defp remove_updated_at_key(user) do
    Map.delete(user, :updated_at)
  end

  defp convert_map_to_struct(user) do
    struct(User, user)
  end
end
