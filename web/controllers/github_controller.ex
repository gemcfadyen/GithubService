defmodule GithubService.GithubController do
  use GithubService.Web, :controller
  alias GithubService.Github.GetUserRepositories
  alias GithubService.Github.FetchLanguages
  alias GithubService.Github.FetchUser

  def performance(conn, _) do
    send_resp conn, 200, "{\n  \"coordinates\": null,\n  \"created_at\": \"Thu Oct 21 16:02:46 +0000 2010\",\n  \"favorited\": false,\n  \"truncated\": false,\n  \"id_str\": \"28039652140\",\n  \"entities\": {\n    \"urls\": [\n      {\n        \"expanded_url\": null,\n        \"url\": \"http://gnip.com/success_stories\",\n        \"indices\": [\n          69,\n          100\n        ]\n      }\n    ],\n    \"hashtags\": [\n\n    ],\n    \"user_mentions\": [\n      {\n        \"name\": \"Gnip, Inc.\",\n        \"id_str\": \"16958875\",\n        \"id\": 16958875,\n        \"indices\": [\n          25,\n          30\n        ],\n        \"screen_name\": \"gnip\"\n      }\n    ]\n  },\n  \"in_reply_to_user_id_str\": null,\n  \"text\": \"what we've been up to at @gnip -- delivering data to happy customers http://gnip.com/success_stories\",\n  \"contributors\": null,\n  \"id\": 28039652140,\n  \"retweet_count\": null,\n  \"in_reply_to_status_id_str\": null,\n  \"geo\": null,\n  \"retweeted\": false,\n  \"in_reply_to_user_id\": null,\n  \"user\": {\n    \"profile_sidebar_border_color\": \"C0DEED\",\n    \"name\": \"Gnip, Inc.\",\n    \"profile_sidebar_fill_color\": \"DDEEF6\",\n    \"profile_background_tile\": false,\n    \"profile_image_url\": \"http://a3.twimg.com/profile_images/62803643/icon_normal.png\",\n    \"location\": \"Boulder, CO\",\n    \"created_at\": \"Fri Oct 24 23:22:09 +0000 2008\",\n    \"id_str\": \"16958875\",\n    \"follow_request_sent\": false,\n    \"profile_link_color\": \"0084B4\",\n    \"favourites_count\": 1,\n    \"url\": \"http://blog.gnip.com\",\n    \"contributors_enabled\": false,\n    \"utc_offset\": -25200,\n    \"id\": 16958875,\n    \"profile_use_background_image\": true,\n    \"listed_count\": 23,\n    \"protected\": false,\n    \"lang\": \"en\",\n    \"profile_text_color\": \"333333\",\n    \"followers_count\": 260,\n    \"time_zone\": \"Mountain Time (US & Canada)\",\n    \"verified\": false,\n    \"geo_enabled\": true,\n    \"profile_background_color\": \"C0DEED\",\n    \"notifications\": false,\n    \"description\": \"Gnip makes it really easy for you to collect social data for your business.\",\n    \"friends_count\": 71,\n    \"profile_background_image_url\": \"http://s.twimg.com/a/1287010001/images/themes/theme1/bg.png\",\n    \"statuses_count\": 302,\n    \"screen_name\": \"gnip\",\n    \"following\": false,\n    \"show_all_inline_media\": false\n  },\n  \"in_reply_to_screen_name\": null,\n  \"source\": \"web\",\n  \"place\": null,\n  \"in_reply_to_status_id\": null\n}"
  end

  def user(conn, %{"username" => username}) do
    user = username
           |> downcase
           |> FetchUser.with_username

    json conn, user
  end

  def user_repos(conn, %{"username" => username}) do
    repos = username
            |> downcase
            |> GetUserRepositories.execute

    json conn, repos
  end

  def repo_languages(conn, %{"username" => username, "repo_name" => repo_name}) do
    languages = username
                |> downcase
                |> FetchLanguages.for_repository(repo_name)
    json conn, languages
  end

  defp downcase(name), do: String.downcase(name)
end
