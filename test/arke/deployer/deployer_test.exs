defmodule Arke.DeployerTest do
  use Arke.DataCase

  alias Arke.Deployer

  describe "amis" do
    alias Arke.Deployer.AMI

    @valid_attrs %{ami_id: "some ami_id", name: "some name"}
    @update_attrs %{ami_id: "some updated ami_id", name: "some updated name"}
    @invalid_attrs %{ami_id: nil, name: nil}

    def ami_fixture(attrs \\ %{}) do
      {:ok, ami} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Deployer.create_ami()

      ami
    end

    test "list_amis/0 returns all amis" do
      ami = ami_fixture()
      assert Deployer.list_amis() == [ami]
    end

    test "get_ami!/1 returns the ami with given id" do
      ami = ami_fixture()
      assert Deployer.get_ami!(ami.id) == ami
    end

    test "create_ami/1 with valid data creates a ami" do
      assert {:ok, %AMI{} = ami} = Deployer.create_ami(@valid_attrs)
      assert ami.ami_id == "some ami_id"
      assert ami.name == "some name"
    end

    test "create_ami/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deployer.create_ami(@invalid_attrs)
    end

    test "update_ami/2 with valid data updates the ami" do
      ami = ami_fixture()
      assert {:ok, ami} = Deployer.update_ami(ami, @update_attrs)
      assert %AMI{} = ami
      assert ami.ami_id == "some updated ami_id"
      assert ami.name == "some updated name"
    end

    test "update_ami/2 with invalid data returns error changeset" do
      ami = ami_fixture()
      assert {:error, %Ecto.Changeset{}} = Deployer.update_ami(ami, @invalid_attrs)
      assert ami == Deployer.get_ami!(ami.id)
    end

    test "delete_ami/1 deletes the ami" do
      ami = ami_fixture()
      assert {:ok, %AMI{}} = Deployer.delete_ami(ami)
      assert_raise Ecto.NoResultsError, fn -> Deployer.get_ami!(ami.id) end
    end

    test "change_ami/1 returns a ami changeset" do
      ami = ami_fixture()
      assert %Ecto.Changeset{} = Deployer.change_ami(ami)
    end
  end
end
