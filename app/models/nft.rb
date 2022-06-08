class Nft < ApplicationRecord
  belongs_to :wallet, dependent: :destroy
  belongs_to :collection, dependent: :destroy
  has_one :photo
  RARITY = %w[Common Uncommon Rare Epic
              Legendary Mythic]
end
