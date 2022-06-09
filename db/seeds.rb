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

def collection_by_offset(offset, limit)
  url = URI("https://api-mainnet.magiceden.dev/v2/collections?offset=#{offset}&limit=#{limit}")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  result = JSON.parse(response.body)
end

def collection_stats(collection)
  url = URI("https://api-mainnet.magiceden.io/rpc/getCollectionHolderStats/#{collection}?edge_cache=true")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  JSON.parse(response.body)
end

def collection(collection)
  url = URI("https://api-mainnet.magiceden.dev/v2/collections/#{collection}/stats")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  JSON.parse(response.body)
end

def save_collections(result)
  result.each do |r|
    sleep 0.6
    collection_hash = collection(r['symbol'])
    collection_more = collection_stats(r['symbol'])
    p collection_more['results']['totalSupply']
    p collection_more['results']['uniqueHolders']
    next unless collection_hash['volumeAll'].present? && collection_hash['volumeAll'] > 5_000_000_000_000
    current_collection = Collection.find_or_initialize_by(symbol: r['symbol'])
    if collection_more['results']['totalSupply'] != 'nil' && collection_more['results']['uniqueHolders']
    current_collection.assign_attributes(name: r['name'], description: r['description'],
                      image: r['image'], twitter: r['twitter'], discord: r['discord'],
                      category: r['categories'], floor_price: collection_hash['floorPrice'],
                      listings: collection_hash['listedCount'], volume: collection_hash['volumeAll'], supply: collection_more['results']['totalSupply'], owner: collection_more['results']['uniqueHolders'])
    current_collection.save!
    end
  end
  puts 'collections saved'
end

def get_buy_and_sell_transactions
  offset = 0
  limit = 500
  result = collection_by_offset(offset, limit)
  while result.length == limit
    save_collections(result)
    offset += limit
    result = collection_by_offset(offset, limit)
    p offset
  end
  save_collections(result)
end

get_buy_and_sell_transactions()
