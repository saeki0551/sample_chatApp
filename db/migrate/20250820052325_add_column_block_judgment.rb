class AddColumnBlockJudgment < ActiveRecord::Migration[8.0]
  def change
        add_column :chat_messages, :block_judgment, :boolean, default: false, null: false
  end
end
