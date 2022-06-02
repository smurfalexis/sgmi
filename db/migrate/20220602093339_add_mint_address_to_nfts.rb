class AddMintAddressToNfts < ActiveRecord::Migration[6.1]
  def change
    add_column :nfts, :mint_address, :string
  end
end
