class CreateSolanaTimestamps < ActiveRecord::Migration[6.1]
  def change
    create_table :solana_timestamps do |t|
      t.date :date
      t.float :price

      t.timestamps
    end
  end
end
