# Extend from the official Elixir image
FROM elixir:1.8.2

RUN apt-get update && \
    apt-get install -y postgresql-client make gcc libc-dev

# Install hex package manager
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force && mix local.rebar --force

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
WORKDIR /app

COPY mix.exs /app
COPY mix.lock /app

RUN mix do deps.get, deps.compile

COPY . /app
