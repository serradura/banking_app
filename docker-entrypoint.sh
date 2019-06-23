#!/bin/bash
# Docker entrypoint script.

# ---------
# functions
# ---------

wait_pg_is_ready() {
  while ! pg_isready -q -h $2 -U $3
  do
    echo "$(date) - waiting for $1 database to start"
    sleep 2
  done
}

setup_databases_to() {
  export MIX_ENV=${1}

  echo -e  "----\n$MIX_ENV\n----"

  mix do event_store.create, event_store.init
  mix do ecto.create, ecto.migrate

  unset MIX_ENV
}

# ----
# main
# ----

wait_pg_is_ready "read model" "$RM_PG_HOSTNAME" "$RM_PG_USERNAME"
wait_pg_is_ready "eventstore" "$ES_PG_HOSTNAME" "$ES_PG_USERNAME"

# Create, migrate database if it doesn't exist.
setup_databases_to "test"
setup_databases_to "dev"

exec mix phx.server
