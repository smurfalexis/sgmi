class DailySolanaJob < ApplicationJob
  queue_as :default

  require "uri"
  require "net/http"
  require 'json'
  require 'date'


  def perform
    url = URI("https://api.coingecko.com/api/v3/coins/solana/history?date=#{Date.today.strftime("%d-%m-%Y")}")
    http = Net::HTTP.new(url.hostname, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    response = http.request(request)
    result = JSON.parse(response.body)
    sol_price = result['market_data']['current_price']['usd']
    SolanaTimestamp.create(date: Date.today, price: sol_price)
  end
end
