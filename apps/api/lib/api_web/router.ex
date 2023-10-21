defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: "*"
  end

  pipeline :auth_token do
    plug ApiWeb.Plugs.GetAuthToken
  end

  scope "/api", ApiWeb do
    pipe_through :api
    get "/api_tokens", ApiTokenController, :index
    get "/api_tokens/new", ApiTokenController, :new
  end

  scope "/", ApiWeb do
    pipe_through([:api, :auth_token])

    post "/calcular-intereses", ProxyController, :calculate_compound_interest
    get "/jokes/:name", ProxyController, :get_joker_data
    get "/weather/:city_name", ProxyController, :get_wheather
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
