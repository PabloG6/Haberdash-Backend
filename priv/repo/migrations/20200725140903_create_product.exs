defmodule Haberdash.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:product, primary_key: false) do
      add :name, :string
      add :price, :integer
      add :description, :text
      add :franchise_id, references(:franchise, on_delete: :delete_all, type: :binary_id)
      add :id, :binary_id, primary_key: true
      timestamps()
    end

    # make sure that every product's name isn't duplicated or created multiple times
    create unique_index(:product, [:name, :franchise_id])
  end
end
