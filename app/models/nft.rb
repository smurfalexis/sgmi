class Nft < ApplicationRecord
  belongs_to :wallet
  belongs_to :collection

end
