defmodule Client do
  @callback get_repositories_for(String.t) :: String.t
  @callback get_languages_for(String.t, String.t) :: String.t
  @callback get_user_with_name(String.t) :: String.t
end
