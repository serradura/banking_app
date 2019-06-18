# BankingApp

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Create the eventstore `mix do event_store.create, event_store.init`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

---

To run the test suite:

1. Setup (only once).
```sh
MIX_ENV=test mix do event_store.create, event_store.init
MIX_ENV=test mix ecto.create
```

2. Run it.
```sh
mix test

# or run the command below to see
# the test results with coverage statistics
MIX_ENV=test mix coveralls
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
