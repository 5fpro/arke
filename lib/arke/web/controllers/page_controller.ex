defmodule Arke.Web.PageController do
  use Arke.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
