defmodule SSChatService.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :public_id, :uuid, null: false
      add :body, :text
      add :message_type, :string, default: "text"
      add :read_at, :utc_datetime
      add :conversation_id, references(:conversations, on_delete: :nothing)
      add :created_by, :uuid
      add :updated_by, :uuid

      timestamps(type: :utc_datetime)
    end

    create index(:messages, [:conversation_id])
    create unique_index(:messages, [:public_id])
  end
end
