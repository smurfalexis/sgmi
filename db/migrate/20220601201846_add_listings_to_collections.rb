class AddListingsToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :listings, :integer
  end
end
