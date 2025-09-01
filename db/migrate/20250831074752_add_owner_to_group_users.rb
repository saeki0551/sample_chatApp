class AddOwnerToGroupUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :group_users, :owner, :string
  end
end
