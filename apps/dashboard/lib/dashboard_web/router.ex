defmodule DashboardWeb.Router do
  use DashboardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DashboardWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DashboardWeb do
    pipe_through :browser

    # get "/", PageController, :home
    get "/", WeatherController, :index
    get "/weathers", WeatherController, :index
    post "/weathers", WeatherController, :post_weather
    get "/chuck_norris_api", ChuckNorrisApiController, :index
    post "/chuck_norris_api", ChuckNorrisApiController, :post_api


    get "/calculate_compound_interests", CompoundInterestController, :index
    post "/calculate_compound_interests", CompoundInterestController, :post_calculate

  end


  if Application.compile_env(:dashboard, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DashboardWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
