class SolanaTimestamp < ApplicationRecord
  private
  def update_daily_price
  url = URI("https://api.coingecko.com/api/v3/coins/solana/history?date=31-05-2022")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  result = JSON.parse(response.body)
  sol_price = result['market_data']['current_price']['usd']
  SolanaTimestamps.create(date: Date.today.prev_day, price: sol_price)
  end
end
