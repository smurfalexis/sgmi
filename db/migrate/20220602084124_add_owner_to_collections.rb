class AddOwnerToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :owner, :integer
  end
end
