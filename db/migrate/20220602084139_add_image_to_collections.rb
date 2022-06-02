class AddImageToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :image, :string
  end
end
