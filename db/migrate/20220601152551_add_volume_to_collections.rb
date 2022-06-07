class AddVolumeToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :volume, :float, scale: 2
  end
end
