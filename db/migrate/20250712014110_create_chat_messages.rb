class CreateChatMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_messages do |t|
      #ここから
      t.references :chat_room, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content
      #ここまでを追記
      t.timestamps
    end
  end
end
