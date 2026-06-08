defmodule SSChatService.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SSChatService.Chat` context.
  """

  @doc """
  Generate a conversation.
  """
  def conversation_fixture(attrs \\ %{}) do
    {:ok, conversation} =
      attrs
      |> Enum.into(%{
        created_by: "7488a646-e31f-11e4-aace-600308960662",
        updated_by: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> SSChatService.Chat.create_conversation()

    conversation
  end

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        body: "some body",
        created_by: "7488a646-e31f-11e4-aace-600308960662",
        updated_by: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> SSChatService.Chat.create_message()

    message
  end
end
