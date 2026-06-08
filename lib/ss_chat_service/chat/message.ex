defmodule SSChatService.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :public_id, Ecto.UUID
    field :body, :string
    field :message_type, :string, default: "text"
    field :read_at, :utc_datetime
    field :created_by, Ecto.UUID
    field :updated_by, Ecto.UUID

    belongs_to :conversation, SSChatService.Chat.Conversation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:public_id, :body, :message_type, :read_at, :created_by, :updated_by, :conversation_id])
    |> validate_required([:public_id, :body, :conversation_id])
    |> validate_inclusion(:message_type, ["text", "image", "system"])
  end
end
