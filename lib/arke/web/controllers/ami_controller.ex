defmodule Arke.Web.AMIController do
  use Arke.Web, :controller

  alias Arke.Deployer
  alias Arke.Deployer.AMI

  action_fallback Arke.Web.FallbackController

  def index(conn, _params) do
    amis = Deployer.list_amis()
    render(conn, "index.json", amis: amis)
  end

  def create(conn, %{"ami" => ami_params}) do
    # with {:ok, %AMI{} = ami} <- Deployer.create_ami(ami_params) do
    #   conn
    #   |> put_status(:created)
    #   |> put_resp_header("location", ami_path(conn, :show, ami))
    #   |> render("show.json", ami: ami)
    # end
  end

  def show(conn, %{"id" => id}) do
    ami = Deployer.get_ami!(id)
    render(conn, "show.json", ami: ami)
  end

  def update(conn, %{"id" => id, "ami" => ami_params}) do
    ami = Deployer.get_ami!(id)

    with {:ok, %AMI{} = ami} <- Deployer.update_ami(ami, ami_params) do
      render(conn, "show.json", ami: ami)
    end
  end

  def delete(conn, %{"id" => id}) do
    ami = Deployer.get_ami!(id)
    with {:ok, %AMI{}} <- Deployer.delete_ami(ami) do
      send_resp(conn, :no_content, "")
    end
  end
end
