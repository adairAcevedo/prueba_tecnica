defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # pipeline :graphql do
  #   plug Plug.Parsers,
  #     parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
  #     pass: ["*/*"],
  #     json_decoder: Jason
  # end
  #   plug Absinthe.Plug,
  #     schema: ApiWeb.Schema
  # end

  scope "/api", ApiWeb do
    pipe_through :api

  end

  # scope "/api-graphql2", ApiWeb do
  #   pipe_through :graphql
  # end

  # plug Plug.Parsers,
  #   parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
  #   pass: ["*/*"],
  #   json_decoder: Jason

  scope "/api-graphql", ApiWeb do
    pipe_through :api

    forward "/", Graphql,
      schema: ApiWeb.Schema,
      json_codec: Jason
      # to: ApiWeb.Graphql,
      # init_opts: [schema: ApiWeb.Schema]
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
