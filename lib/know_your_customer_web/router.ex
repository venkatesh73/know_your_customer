defmodule KYCWeb.Router do
  use KYCWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {KYCWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KYCWeb do
    pipe_through [:browser, KYCWeb.Plugs.Guest]

    get "/login", SessionController, :index
    post "/login", SessionController, :submit

    get "/sign_up", SessionController, :sign_up
    post "/sign_up", SessionController, :create
  end

  scope "/", KYCWeb do
    pipe_through [:browser, KYCWeb.Plugs.Authorized]

    get "/", HomeController, :index

    get "/add", HomeController, :add
    post "/add", HomeController, :create

    delete "/delete/:id", HomeController, :delete

    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", KYCWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: KYCWeb.Telemetry
    end
  end
end
