class CreateCollections < ActiveRecord::Migration[6.1]
  def change
    create_table :collections do |t|
      t.string :name
      t.jsonb :floor_price, scale: 2

      t.timestamps
    end
  end
end
