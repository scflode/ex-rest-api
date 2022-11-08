defmodule RestApi.Repo.Migrations.AddFirstLastName do
  use Ecto.Migration

  def change do
    alter table(:registrations) do
      add :first_name, :string
      add :last_name, :string
    end
  end
end
