defmodule Bgt.Router do
  use Bgt.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Openmaize.Authenticate
  end

  scope "/", Bgt do
    pipe_through :browser

    get "/", PageController, :index

    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end
end
