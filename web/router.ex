defmodule PhoenixLobsters.Router do
  use PhoenixLobsters.Web, :router

  @moduledoc """
  Router for our Phoenix application  
  """

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhoenixLobsters.Plugs.AuthenticateUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixLobsters do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/signin", SessionController, :new
    post "/signin", SessionController, :create
    get "/signout", SessionController, :destroy

    get "/registration/new", RegistrationController, :new
    post "/registration", RegistrationController, :create

    get "/stories/new", StoryController, :new
    post "/stories/submit", StoryController, :create
    get "/stories/:id", StoryController, :show
    delete "/stories/:id", StoryController, :destroy

    post "/comments", CommentController, :create
  end

  # Other scopes may use custom stacks.
  scope "/api", PhoenixLobsters.Api do
    pipe_through :api

    post "/register", AuthenticationController, :register
    post "/signin", AuthenticationController, :signin

    get "/stories", StoryController, :index
  end
end
