class DeleteGroupNameUniqueFromGroups < ActiveRecord::Migration[8.0]
  def change
    remove_column  :groups, :name, null: false
    remove_column  :groups, :name, unique: true
    add_column :groups, :name, :string
  end
end
