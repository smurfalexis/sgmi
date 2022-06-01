class AddTwitterToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :twitter, :string
  end
end
