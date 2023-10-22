defmodule DashboardWeb.PageController do
  use DashboardWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # headers = ["X-API-TOKEN": "kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy", "Accept": "Application/json; Charset=utf-8"]
    # DahsboardWeb.HTTP.get("/jokes/random", headers) |> IO.inspect
    render(conn, :home, layout: false)
  end


  def api_tokens(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    headers = ["X-API-TOKEN": "kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy", "Accept": "Application/json; Charset=utf-8"]
    DahsboardWeb.HTTP.get("/jokes/random", headers) |> IO.inspect
    render(conn, :home, layout: false)
  end

  # def api_tokens(conn, _params) do
  #   # The home page is often custom made,
  #   # so skip the default app layout.
  #   headers = ["X-API-TOKEN": "kFYqXqXC9YdzVMHyaEYP9SKSQx7PcPFy", "Accept": "Application/json; Charset=utf-8"]
  #   DahsboardWeb.HTTP.get("/jokes/random", headers) |> IO.inspect
  #   render(conn, :home, layout: false)
  # end



end
