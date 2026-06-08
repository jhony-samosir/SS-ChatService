defmodule SSChatService.Chat.Participant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conversation_participants" do
    field :public_id, Ecto.UUID
    field :user_id, Ecto.UUID
    field :role, :string

    belongs_to :conversation, SSChatService.Chat.Conversation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:public_id, :user_id, :role, :conversation_id])
    |> validate_required([:public_id, :user_id, :role, :conversation_id])
    |> validate_inclusion(:role, ["buyer", "seller"])
  end
end
