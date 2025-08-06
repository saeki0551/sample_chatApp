class ChangeGroupIdNullChatMessages < ActiveRecord::Migration[8.0]
  def change
    change_column_null :chat_messages, :group_id, true
  end
end
