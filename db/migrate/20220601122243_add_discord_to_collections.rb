class AddDiscordToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :discord, :string
  end
end
