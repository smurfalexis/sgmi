class AddVolume24ToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :volume24, :float
  end
end
