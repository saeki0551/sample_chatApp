class CreateBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :blocks do |t|
      t.integer :block_user_id
      t.integer :blocked_user_id
      t.references :user, foreign_key: true #この行はいらなかった。関連付けしているから。
      t.timestamps
    end
  end
end
