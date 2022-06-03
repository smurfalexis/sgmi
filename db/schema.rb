# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_02_104646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.float "floor_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "category"
    t.text "description"
    t.string "symbol"
    t.string "discord"
    t.string "twitter"
    t.string "website"
    t.float "volume"
    t.integer "listings"
    t.integer "supply"
    t.integer "owner"
    t.string "image"
    t.float "volume24"
  end

  create_table "nfts", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "image"
    t.string "rarity"
    t.bigint "wallet_id", null: false
    t.bigint "collection_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "purchase_date"
    t.string "mint_address"
    t.index ["collection_id"], name: "index_nfts_on_collection_id"
    t.index ["wallet_id"], name: "index_nfts_on_wallet_id"
  end

  create_table "solana_timestamps", force: :cascade do |t|
    t.date "date"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.string "wallet_key"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  create_table "watchlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "collection_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["collection_id"], name: "index_watchlists_on_collection_id"
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

  add_foreign_key "nfts", "collections"
  add_foreign_key "nfts", "wallets"
  add_foreign_key "wallets", "users"
  add_foreign_key "watchlists", "collections"
  add_foreign_key "watchlists", "users"
end
