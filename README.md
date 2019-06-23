# BankingApp

To start your Phoenix server:

1. Do you have docker and docker compose Installed?
    If not, head over to [Docker's website](https://docs.docker.com/install/) and install a version of Docker for your operating system of choice.
2. Build the app `docker-compose build`
3. Start it `docker-compose up`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

**PgWeb**

By default the `docker-compose up` will exposes Pgweb (a web-based database browser for PostgreSQL) in [`localhost:8081`](http://localhost:8081)

Available URL schemes to connect:
1. `postgres://postgres:postgres@pg_read_model:5432/banking_app_dev?sslmode=disable`
2. `postgres://postgres:postgres@pg_eventstore:5432/banking_app_eventstore_dev?sslmode=disable`

---

To run the test suite:

```sh
docker-compose run web /bin/bash

# Run inside of the container
mix test

# or run the command below to see
# the test results with coverage statistics
mix coveralls

# open ./cover/excoveralls.html
```
