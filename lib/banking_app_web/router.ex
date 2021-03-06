defmodule BankingAppWeb.Router do
  use BankingAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BankingAppWeb.Auth.Pipeline
  end

  scope "/", BankingAppWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", BankingAppWeb.API do
    pipe_through :api

    resources "/users", UserController, only: [:create]
    resources "/users/login", SessionController, only: [:create]
  end

  scope "/api", BankingAppWeb.API do
    pipe_through [:api, :auth]

    resources "/account", AccountController, only: [:show], singleton: true
  end
end
