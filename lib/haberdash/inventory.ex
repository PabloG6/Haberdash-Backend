defmodule Haberdash.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias Haberdash.Repo
  use Nebulex.Caching
  alias Haberdash.Inventory.Products

  @doc """
  Returns the list of product when given the franchise id.

  ## Examples

      iex> list_product(id)
      [%Products{}, ...]

  """
  def list_product(id) do
    Repo.all(from p in Products, where: p.franchise_id == ^id)
  end

  def list_product(), do: Repo.all(Products)

  @doc """
  Gets a single products.

  Raises `Ecto.NoResultsError` if the Products does not exist.

  ## Examples

      iex> get_products!("a4f21755-235a-4330-b8af-933c362ea294")
      %Products{}

      iex> get_products!("070e8696-fad5-4698-8808-c9ce8b47197d")
      ** (Ecto.NoResultsError)

  """
  def get_products!(id), do: Repo.get!(Products, id)

  @doc """
  Creates a products.

  ## Examples

      iex> create_products(%{field: value})
      {:ok, %Products{}}

      iex> create_products(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_products(attrs \\ %{}) do
    %Products{}
    |> Products.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a products.

  ## Examples

      iex> update_products(products, %{field: new_value})
      {:ok, %Products{}}

      iex> update_products(products, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_products(%Products{} = products, attrs) do
    products
    |> Products.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a products.

  ## Examples

      iex> delete_products(products)
      {:ok, %Products{}}

      iex> delete_products(products)
      {:error, %Ecto.Changeset{}}

  """
  def delete_products(%Products{} = products) do
    Repo.delete(products)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking products changes.

  ## Examples

      iex> change_products(products)
      %Ecto.Changeset{data: %Products{}}

  """
  def change_products(%Products{} = products, attrs \\ %{}) do
    Products.changeset(products, attrs)
  end

end
