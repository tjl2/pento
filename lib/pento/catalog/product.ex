defmodule Pento.Catalog.Product do
  @moduledoc """
  The Product context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0.0)
  end

  @doc """
  Decrease the price of a product by a given amount.

  ## Examples
  iex> decrease_price(product, %{unit_price: 10.0})
  {:ok, %Product{}}

  iex> decrease_price(product, %{unit_price: 100.0})
  {:error, %Ecto.Changeset{}}
  """
  def decrease_price(product, attrs) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_number(:unit_price, less_than: product.unit_price)
  end
end
