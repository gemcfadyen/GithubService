# GithubService

This application is a mirror for the service https://api.github.com/users/HackerYou. The mirro was created to act as a data cache because there is a limited number of hits you can make to the real api in a 24 hour period.

Each time the mirror is hit, the results are persisted in a database.

The application is deployed on heroku: https://github-api-mirror.herokuapp.com

## Supported Queries

To query for user details:

https://github-api-mirror.herokuapp.com/users/<username>

To query for the repositories of a given user:

https://github-api-mirror.herokuapp.com/users/<username>/repos

To query for the languages used in a particular repository:

https://github-api-mirror.herokuapp.com/repos/<username>/<repo-name>/languages

To experiment, try using username = `hackeryou` and repo-name = `amazon`

## Running the app locally

You need to have Elixir installed, and postgres

Clone the repository
> git clone git@github.com:gemcfadyen/GithubService.git

Navigate to the root directory
> cd github_service

Install dependencies
> mix deps.get

Compile the code
> mix compile

Build the database (dev env)
> mix ecto.create
> mix ecto.migrate

Build the database (test env)
> MIX_ENV=test mix ecto.create
> MIX_ENV=test mix ecto.migrate

Run the tests (including integration tests)
> mix test

Run the tests (excluding integration tests)
> mix test --exclude integration

Start the server locally
> mix phoenix.server

Navigate to a supported url
> https://localhost:4000/repos/<username>/<repo-name>/languages

## Deploying the app to Heroku

Build the database
> heroku run "POOL_SIZE=2 mix ecto.migrate"

Push master to heroku
> git push heroku master

To connect to the heroku database
> heroku pg:psql

To view the heroku logs
> heroku logs --tail

To view the heroku database logs
> heroku logs --tail --ps heroku-postgres
