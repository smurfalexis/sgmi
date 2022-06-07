class Collection < ApplicationRecord
  has_many :nfts
  has_one :photo
  CATEGORIES = %w[Gaming Music Sports Art
                  Utility Metaverse]
  include PgSearch::Model
  pg_search_scope :search_by_keyword,
                  against: %i[name category description],
                  using: {
                    tsearch: { prefix: true }
                  }
SOL = 0.000000001

def floor_price_in_sol
  floor_price * SOL
end

def volume_in_sol
  volume * SOL
end

end
