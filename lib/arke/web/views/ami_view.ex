defmodule Arke.Web.AMIView do
  use Arke.Web, :view
  alias Arke.Web.AMIView

  def render("index.json", %{amis: amis}) do
    %{data: render_many(amis, AMIView, "ami.json")}
  end

  def render("show.json", %{ami: ami}) do
    %{data: render_one(ami, AMIView, "ami.json")}
  end

  def render("ami.json", %{ami: ami}) do
    %{id: ami.id,
      name: ami.name,
      ami_id: ami.ami_id}
  end
end
