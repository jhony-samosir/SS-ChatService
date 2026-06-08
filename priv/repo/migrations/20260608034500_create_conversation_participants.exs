defmodule SSChatService.Repo.Migrations.CreateConversationParticipants do
  use Ecto.Migration

  def change do
    create table(:conversation_participants) do
      add :public_id, :uuid, null: false
      add :conversation_id, references(:conversations, on_delete: :nothing)
      add :user_id, :uuid, null: false
      add :role, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:conversation_participants, [:conversation_id])
    create index(:conversation_participants, [:user_id])
    create unique_index(:conversation_participants, [:public_id])
  end
end
