class ChangeChatRoomIdNullChatMessages < ActiveRecord::Migration[8.0]
  def change
    change_column_null :chat_messages, :chat_room_id, true
  end
end
