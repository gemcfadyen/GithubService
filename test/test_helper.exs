ExUnit.start

Mix.Task.run "ecto.create", ~w(-r GithubService.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r GithubService.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(GithubService.Repo)

