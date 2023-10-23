defmodule DashboardWeb.PageController do
  use DashboardWeb, :controller

  def home(conn, _params) do

    render(conn, :home, layout: false)
  end


  def api_tokens(conn, _params) do
    render(conn, :home, layout: false)
  end



end
