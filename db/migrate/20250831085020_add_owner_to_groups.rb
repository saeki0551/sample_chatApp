class AddOwnerToGroups < ActiveRecord::Migration[8.0]
  def change
    add_column :groups, :owner, :string
  end
end
