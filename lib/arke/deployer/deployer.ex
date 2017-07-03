defmodule Arke.Deployer do
  @moduledoc """
  The boundary for the Deployer system.
  """

  import Ecto.Query, warn: false
  alias Arke.Repo

  alias Arke.Deployer.AMI

  @doc """
  Returns the list of amis.

  ## Examples

      iex> list_amis()
      [%AMI{}, ...]

  """
  def list_amis do
    Repo.all(AMI)
  end

  @doc """
  Gets a single ami.

  Raises `Ecto.NoResultsError` if the Ami does not exist.

  ## Examples

      iex> get_ami!(123)
      %AMI{}

      iex> get_ami!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ami!(id), do: Repo.get!(AMI, id)

  @doc """
  Creates a ami.

  ## Examples

      iex> create_ami(%{field: value})
      {:ok, %AMI{}}

      iex> create_ami(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ami(attrs \\ %{}) do
    %AMI{}
    |> AMI.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ami.

  ## Examples

      iex> update_ami(ami, %{field: new_value})
      {:ok, %AMI{}}

      iex> update_ami(ami, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ami(%AMI{} = ami, attrs) do
    ami
    |> AMI.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AMI.

  ## Examples

      iex> delete_ami(ami)
      {:ok, %AMI{}}

      iex> delete_ami(ami)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ami(%AMI{} = ami) do
    Repo.delete(ami)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ami changes.

  ## Examples

      iex> change_ami(ami)
      %Ecto.Changeset{source: %AMI{}}

  """
  def change_ami(%AMI{} = ami) do
    AMI.changeset(ami, %{})
  end
end
