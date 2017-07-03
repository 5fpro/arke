defmodule Arke.Web.AMIControllerTest do
  use Arke.Web.ConnCase

  alias Arke.Deployer
  alias Arke.Deployer.AMI

  @create_attrs %{ami_id: "some ami_id", name: "some name"}
  @update_attrs %{ami_id: "some updated ami_id", name: "some updated name"}
  @invalid_attrs %{ami_id: nil, name: nil}

  def fixture(:ami) do
    {:ok, ami} = Deployer.create_ami(@create_attrs)
    ami
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, ami_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates ami and renders ami when data is valid", %{conn: conn} do
    conn = post conn, ami_path(conn, :create), ami: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, ami_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "ami_id" => "some ami_id",
      "name" => "some name"}
  end

  test "does not create ami and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, ami_path(conn, :create), ami: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen ami and renders ami when data is valid", %{conn: conn} do
    %AMI{id: id} = ami = fixture(:ami)
    conn = put conn, ami_path(conn, :update, ami), ami: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, ami_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "ami_id" => "some updated ami_id",
      "name" => "some updated name"}
  end

  test "does not update chosen ami and renders errors when data is invalid", %{conn: conn} do
    ami = fixture(:ami)
    conn = put conn, ami_path(conn, :update, ami), ami: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen ami", %{conn: conn} do
    ami = fixture(:ami)
    conn = delete conn, ami_path(conn, :delete, ami)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, ami_path(conn, :show, ami)
    end
  end
end
