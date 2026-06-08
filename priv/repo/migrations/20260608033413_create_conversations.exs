defmodule SSChatService.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations) do
      add :public_id, :uuid, null: false
      add :reference_type, :string
      add :reference_id, :uuid
      add :created_by, :uuid
      add :updated_by, :uuid

      timestamps(type: :utc_datetime)
    end

    create unique_index(:conversations, [:public_id])
  end
end
