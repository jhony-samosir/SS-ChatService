defmodule SSChatServiceWeb.ConversationController do
  use SSChatServiceWeb, :controller

  alias SSChatService.Chat

  def index(conn, _params) do
    user_id = get_req_header(conn, "x-user-id") |> List.first() || conn.params["user_id"]

    if user_id do
      conversations = Chat.list_user_conversations(user_id)
      # We render directly via JSON for simplicity, or use JSON view.
      # Using native json encoder:
      conn
      |> put_status(:ok)
      |> json(%{data: render_conversations(conversations)})
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Missing user authentication"})
    end
  end

  defp render_conversations(conversations) do
    Enum.map(conversations, fn c ->
      %{
        id: c.id,
        public_id: c.public_id,
        reference_type: c.reference_type,
        reference_id: c.reference_id,
        participants: Enum.map(c.participants, fn p ->
          %{user_id: p.user_id, role: p.role}
        end)
      }
    end)
  end
end
