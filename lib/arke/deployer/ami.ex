defmodule Arke.Deployer.AMI do
  use Ecto.Schema
  import Ecto.Changeset
  alias Arke.Deployer.AMI


  schema "deployer_amis" do
    field :ami_id, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%AMI{} = ami, attrs) do
    ami
    |> cast(attrs, [:name, :ami_id])
    |> validate_required([:name, :ami_id])
  end
end
