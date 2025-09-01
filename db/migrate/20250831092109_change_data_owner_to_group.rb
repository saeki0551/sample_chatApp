class ChangeDataOwnerToGroup < ActiveRecord::Migration[8.0]
  def change
    change_column :groups, :owner, :integers
  end
end
