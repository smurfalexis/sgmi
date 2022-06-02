class AddWatchlistToUsers < ActiveRecord::Migration[6.1]
  def change
    User.find_each do |user|
      user.create_watchlist
    end 
  end
end
