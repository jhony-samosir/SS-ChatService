defmodule SSChatServiceWeb.ChatController do
  use SSChatServiceWeb, :controller

  alias SSChatService.Chat

  action_fallback SSChatServiceWeb.FallbackController

  @doc """
  Create a new message in a conversation.
  Demonstrates N-Layer separation: Controller only handles HTTP, Context handles logic.
  """
  def create_message(conn, %{"message" => message_params}) do
    case Chat.create_message(message_params) do
      {:ok, message} ->
        conn
        |> put_status(:created)
        |> json(%{data: %{id: message.id, body: message.body}})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: SSChatServiceWeb.ErrorJSON)
        |> render(:"422", changeset: changeset)
    end
  end
end
