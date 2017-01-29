# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170129220120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.text     "description"
    t.decimal  "min_price"
    t.decimal  "max_price"
    t.string   "size"
    t.string   "recipient_address"
    t.string   "recipient_name"
    t.string   "recipient_phonenumber"
    t.string   "recipient_email"
    t.string   "sample_picture"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.date     "delivery_date"
    t.string   "sender_name"
    t.string   "sender_address"
    t.string   "sender_email"
    t.string   "sender_phonenumber"
    t.integer  "seller_id"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "orders_tags", id: false, force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "tag_id",   null: false
  end

  add_index "orders_tags", ["order_id", "tag_id"], name: "index_orders_tags_on_order_id_and_tag_id", using: :btree
  add_index "orders_tags", ["tag_id", "order_id"], name: "index_orders_tags_on_tag_id_and_order_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "user_id"
    t.string   "imageone"
    t.string   "imagetwo"
    t.string   "imagethree"
    t.string   "imagefour"
    t.integer  "shop_id"
    t.string   "size",        default: "not specified"
    t.boolean  "approved",    default: false
  end

  add_index "products", ["shop_id"], name: "index_products_on_shop_id", using: :btree
  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "products_tags", id: false, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "tag_id",     null: false
  end

  add_index "products_tags", ["product_id", "tag_id"], name: "index_products_tags_on_product_id_and_tag_id", using: :btree
  add_index "products_tags", ["tag_id", "product_id"], name: "index_products_tags_on_tag_id_and_product_id", using: :btree

  create_table "searches", force: :cascade do |t|
    t.string   "keywords"
    t.string   "name"
    t.decimal  "max_price"
    t.decimal  "min_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "size"
    t.string   "category"
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "location"
    t.datetime "opening"
    t.datetime "closing"
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "approved",    default: false
  end

  add_index "shops", ["user_id"], name: "index_shops_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.integer  "age",                    default: 0
    t.boolean  "seller",                 default: false
    t.boolean  "admin",                  default: false
    t.string   "gender",                 default: "female"
    t.string   "image"
    t.string   "fullname"
    t.string   "twitter_image"
    t.string   "phonenumber"
    t.boolean  "suspended",              default: false
    t.string   "address"
    t.integer  "admin_access_level",     default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "identities", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "shops"
  add_foreign_key "products", "users"
  add_foreign_key "shops", "users"
end
