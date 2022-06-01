class ChangeVolumeToDecimal < ActiveRecord::Migration[6.1]
  def change
    change_column(:collections, :volume, :decimal, scale: 2, precision: 10)
  end
end
