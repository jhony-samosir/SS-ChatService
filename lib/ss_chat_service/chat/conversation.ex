defmodule SSChatService.Chat.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conversations" do
    field :public_id, Ecto.UUID
    field :reference_type, :string
    field :reference_id, Ecto.UUID
    field :created_by, Ecto.UUID
    field :updated_by, Ecto.UUID

    has_many :participants, SSChatService.Chat.Participant
    has_many :messages, SSChatService.Chat.Message

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:public_id, :reference_type, :reference_id, :created_by, :updated_by])
    |> validate_required([:public_id])
  end
end
