# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'uri'
require 'net/http'
require 'json'

SolanaTimestamp.destroy_all
Nft.destroy_all
Collection.destroy_all
Wallet.destroy_all
User.destroy_all

csv_solana = File.read(Rails.root.join('db/solana_prices.csv'))
solana_history = CSV.parse(csv_solana, headers: true, encoding: 'ISO-8859-1')

solana_history.each do |row|
  SolanaTimestamp.create(
    date: row['timestamp'],
    price: row['high']
  )
end

mahmoud = User.new({ email: 'mahmoud@gmail.com', password: '123456', first_name: 'Mahmoud', last_name: 'Hajji' })
spiros = User.new({ email: 'spiros12@gmail.com', password: '123456', first_name: 'Spiros', last_name: 'Tsiakalos' })
raisa = User.new({ email: 'raise@gmail.com', password: '123456', first_name: 'Raisa', last_name: 'Tarase' })
alex = User.new({ email: 'alex@gmail.com', password: '123456', first_name: 'Alexandra', last_name: 'Hedman' })
spiros.save
mahmoud.save
raisa.save
alex.save

# Wallets:
wallet1 = Wallet.create(wallet_key: '12345678', user: alex)
wallet2 = Wallet.create(wallet_key: '23456789', user: mahmoud)
wallet3 = Wallet.create(wallet_key: '56789043', user: spiros)
wallet4 = Wallet.create(wallet_key: '23689045', user: raisa)

def get_all_collections
  offset = 0
  limit = 500
  result = collection_by_offset(offset, limit)
  while result.length == limit
    sleep 2
    puts 'sleeping for 2 , calling api again'
    save_collections(result)
    offset += limit
    result = collection_by_offset(offset, limit)
    p offset
  end
  save_collections(result)
end

def collection_by_offset(offset, limit)
  url = URI("https://api-mainnet.magiceden.dev/v2/collections?offset=#{offset}&limit=#{limit}")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  result = JSON.parse(response.body)
end

def save_collections(result)
  result.each do |r|
    sleep 0.7
    collection_hash = collection(r['symbol'])
    p collection_hash
    next unless collection_hash['volumeAll'].present? && collection_hash['volumeAll'] > 5_000_000_000_000
    Collection.create(symbol: r['symbol'], name: r['name'], description: r['description'],
                      image: r['image'], twitter: r['twitter'], discord: r['discord'],
                      category: r['categories'], floor_price: collection_hash['floorPrice'],
                      listings: collection_hash['listedCount'], volume: collection_hash['volumeAll'])
  end
  puts 'collections saved'
end

def collection(collection)
  url = URI("https://api-mainnet.magiceden.dev/v2/collections/#{collection}/stats")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  JSON.parse(response.body)
end

get_all_collections
