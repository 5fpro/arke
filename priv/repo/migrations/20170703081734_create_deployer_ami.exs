defmodule Arke.Repo.Migrations.CreateArke.Deployer.AMI do
  use Ecto.Migration

  def change do
    create table(:deployer_amis) do
      add :name, :string
      add :ami_id, :string

      timestamps()
    end

  end
end
