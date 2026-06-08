defmodule SSChatServiceWeb.RoomChannel do
  use Phoenix.Channel

  alias SSChatService.Chat

  @impl true
  def join("room:" <> conversation_id, _payload, socket) do
    # Join PubSub topic manually so handle_info receives the broadcast from context
    Phoenix.PubSub.subscribe(SSChatService.PubSub, "room:#{conversation_id}")
    {:ok, assign(socket, :conversation_id, conversation_id)}
  end

  @impl true
  def handle_in("new_msg", %{"body" => body}, socket) do
    attrs = %{
      conversation_id: socket.assigns.conversation_id,
      body: body,
      created_by: socket.assigns.user_id,
      public_id: Ecto.UUID.generate()
    }

    case Chat.create_message(attrs) do
      {:ok, _message} ->
        {:reply, :ok, socket}

      {:error, _changeset} ->
        {:reply, {:error, %{reason: "Failed to save message"}}, socket}
    end
  end

  @impl true
  def handle_info({:new_message, message}, socket) do
    push(socket, "new_msg", %{
      id: message.id,
      public_id: message.public_id,
      body: message.body,
      message_type: message.message_type,
      created_by: message.created_by,
      inserted_at: message.inserted_at
    })
    {:noreply, socket}
  end
end
