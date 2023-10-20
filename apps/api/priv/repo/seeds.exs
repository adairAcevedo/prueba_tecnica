# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Api.Repo.insert!(%Api.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, api_token} = Api.Accounts.create_api_token(%{token: "kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy", last_hour_count: 18})
Api.Accounts.create_api_token(%{token: Api.Apicore.generate_random_key, last_hour_count: 15})

Api.Accounts.create_history_api_token(%{api_token_id: api_token.id, time_request: Timex.now})
Api.Accounts.create_history_api_token(%{api_token_id: api_token.id, time_request: Timex.now})
Api.Accounts.create_history_api_token(%{api_token_id: api_token.id, time_request: Timex.now})
Api.Accounts.create_history_api_token(%{api_token_id: api_token.id, time_request: Timex.now})
Api.Accounts.create_history_api_token(%{api_token_id: api_token.id, time_request: Timex.now})
