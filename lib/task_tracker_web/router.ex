defmodule TaskTrackerWeb.Router do
  use TaskTrackerWeb, :router
  alias TaskTracker.Repo

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # not belong there
  def get_current_user(conn, _params) do
    # TODO: Move this function out of the router module.
    user_id = get_session(conn, :user_id)
    user = TaskTracker.Accounts.get_user(user_id || -1)
    if user do
      user = user |> Repo.preload(:manager_part)
    end
    assign(conn, :current_user, user)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", TaskTrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    post "/session", SessionController, :create
    delete "/session", SessionController, :delete

    resources "/users", UserController
    resources "/tasks", TaskController
    resources "/tests", TestController
    resources "/managers", ManagerController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaskTrackerWeb do
  #   pipe_through :api
  # end
  scope "/api/v1", TaskTrackerWeb do
    pipe_through :api
    resources "/time_blocks", TimeBlockController
  end
end
