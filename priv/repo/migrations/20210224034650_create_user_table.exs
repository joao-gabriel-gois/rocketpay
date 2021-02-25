defmodule Rocketpay.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  # change creates a way to create table and also rollback tables
  def change do
    create table :users do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password_hash, :string
      add :nickname, :string

      timestamps() # adds 2 columns -> iserted_at, created_at
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end
end
