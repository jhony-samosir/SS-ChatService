defmodule SSChatService.ChatTest do
  use SSChatService.DataCase

  alias SSChatService.Chat

  describe "conversations" do
    alias SSChatService.Chat.Conversation

    import SSChatService.ChatFixtures

    @invalid_attrs %{created_by: nil, updated_by: nil}

    test "list_conversations/0 returns all conversations" do
      conversation = conversation_fixture()
      assert Chat.list_conversations() == [conversation]
    end

    test "get_conversation!/1 returns the conversation with given id" do
      conversation = conversation_fixture()
      assert Chat.get_conversation!(conversation.id) == conversation
    end

    test "create_conversation/1 with valid data creates a conversation" do
      valid_attrs = %{created_by: "7488a646-e31f-11e4-aace-600308960662", updated_by: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %Conversation{} = conversation} = Chat.create_conversation(valid_attrs)
      assert conversation.created_by == "7488a646-e31f-11e4-aace-600308960662"
      assert conversation.updated_by == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_conversation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_conversation(@invalid_attrs)
    end

    test "update_conversation/2 with valid data updates the conversation" do
      conversation = conversation_fixture()
      update_attrs = %{created_by: "7488a646-e31f-11e4-aace-600308960668", updated_by: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %Conversation{} = conversation} = Chat.update_conversation(conversation, update_attrs)
      assert conversation.created_by == "7488a646-e31f-11e4-aace-600308960668"
      assert conversation.updated_by == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_conversation/2 with invalid data returns error changeset" do
      conversation = conversation_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_conversation(conversation, @invalid_attrs)
      assert conversation == Chat.get_conversation!(conversation.id)
    end

    test "delete_conversation/1 deletes the conversation" do
      conversation = conversation_fixture()
      assert {:ok, %Conversation{}} = Chat.delete_conversation(conversation)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_conversation!(conversation.id) end
    end

    test "change_conversation/1 returns a conversation changeset" do
      conversation = conversation_fixture()
      assert %Ecto.Changeset{} = Chat.change_conversation(conversation)
    end
  end

  describe "messages" do
    alias SSChatService.Chat.Message

    import SSChatService.ChatFixtures

    @invalid_attrs %{body: nil, created_by: nil, updated_by: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chat.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chat.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{body: "some body", created_by: "7488a646-e31f-11e4-aace-600308960662", updated_by: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %Message{} = message} = Chat.create_message(valid_attrs)
      assert message.body == "some body"
      assert message.created_by == "7488a646-e31f-11e4-aace-600308960662"
      assert message.updated_by == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{body: "some updated body", created_by: "7488a646-e31f-11e4-aace-600308960668", updated_by: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %Message{} = message} = Chat.update_message(message, update_attrs)
      assert message.body == "some updated body"
      assert message.created_by == "7488a646-e31f-11e4-aace-600308960668"
      assert message.updated_by == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, @invalid_attrs)
      assert message == Chat.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chat.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chat.change_message(message)
    end
  end
end
