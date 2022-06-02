class ChangeFloorPriceToDecimal < ActiveRecord::Migration[6.1]
  def change
    change_column(:collections, :floor_price, :decimal, scale: 2, precision: 10)
  end
end
