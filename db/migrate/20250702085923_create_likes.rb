class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      #ここから
      t.references :to_user, null: false, foreign_key: { to_table: :users }
      t.references :from_user, null: false, foreign_key: { to_table: :users }
      t.integer :status, null: false
      #ここまで追記
      t.timestamps 
    end
  end
end
