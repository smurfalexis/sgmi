require 'uri'
require 'net/http'
require 'json'
require 'date'

namespace :solana_timestamp do
  desc "Fetching daily solana price"
  task get_solana_daily: :environment do
    puts "fetching price"
    DailySolanaJob.perform_now
  end
  puts "done"
end
