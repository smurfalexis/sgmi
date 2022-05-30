class CreateCollections < ActiveRecord::Migration[6.1]
  def change
    create_table :collections do |t|
      t.string :name
      t.float :floor_price

      t.timestamps
    end
  end
end
