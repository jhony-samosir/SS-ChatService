defmodule SSChatServiceWeb.MessageController do
  use SSChatServiceWeb, :controller

  alias SSChatService.Chat

  def index(conn, %{"id" => conversation_id}) do
    user_id = get_req_header(conn, "x-user-id") |> List.first() || conn.params["user_id"]

    if user_id do
      messages = Chat.list_conversation_messages(conversation_id)
      conn
      |> put_status(:ok)
      |> json(%{data: render_messages(messages)})
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Missing user authentication"})
    end
  end

  def create(conn, %{"id" => conversation_id, "body" => body}) do
    user_id = get_req_header(conn, "x-user-id") |> List.first() || conn.params["user_id"]

    if user_id do
      attrs = %{
        conversation_id: conversation_id,
        body: body,
        created_by: user_id,
        public_id: Ecto.UUID.generate()
      }

      case Chat.create_message(attrs) do
        {:ok, message} ->
          conn
          |> put_status(:created)
          |> json(%{data: render_message(message)})
        {:error, _changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{error: "Failed to create message"})
      end
    else
      conn |> put_status(:unauthorized) |> json(%{error: "Missing user authentication"})
    end
  end

  defp render_messages(messages) do
    Enum.map(messages, &render_message/1)
  end

  defp render_message(m) do
    %{
      id: m.id,
      public_id: m.public_id,
      body: m.body,
      message_type: m.message_type,
      created_by: m.created_by,
      inserted_at: m.inserted_at
    }
  end
end
