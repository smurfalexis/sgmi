class User < ApplicationRecord
  after_create :create_watchlist
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :wallets
  has_many :nfts, through: :wallets
  has_one :watchlist, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  private


  def create_watchlist
    @watchlist = Watchlist.create(user: self)
  end
end
