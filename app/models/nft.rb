class Nft < ApplicationRecord
  belongs_to :wallet
  belongs_to :collection
  has_one :photo
  RARITY = %w[Common Uncommon Rare Epic
              Legendary Mythic]
end
