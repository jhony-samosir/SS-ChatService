defmodule SSChatService.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "messages" do
    field :body, :string
    field :created_by, Ecto.UUID
    field :updated_by, Ecto.UUID
    field :conversation_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :created_by, :updated_by])
    |> validate_required([:body, :created_by, :updated_by])
  end
end
