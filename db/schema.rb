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

ActiveRecord::Schema.define(version: 20171026232610) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "house_id"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_bookings_on_house_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.string   "card_id",      null: false
    t.string   "brand",        null: false
    t.string   "fingerprint",  null: false
    t.string   "exp_month",    null: false
    t.string   "exp_year",     null: false
    t.integer  "last4_digits", null: false
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string   "home_type"
    t.integer  "bed_room"
    t.integer  "bath_room"
    t.integer  "garage"
    t.integer  "sq_feet"
    t.string   "listing_name"
    t.text     "summary"
    t.text     "repairs"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.boolean  "is_air"
    t.boolean  "is_heating"
    t.boolean  "is_occupied"
    t.boolean  "is_pool"
    t.boolean  "warranty"
    t.integer  "price"
    t.boolean  "active"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "Neighboorhood"
    t.string   "lead_price"
    t.boolean  "storage"
    t.boolean  "hardwood"
    t.boolean  "carpet"
    t.boolean  "stove"
    t.boolean  "fridge"
    t.index ["user_id"], name: "index_houses_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "context"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "house_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["house_id"], name: "index_photos_on_house_id"
  end

  create_table "settings", force: :cascade do |t|
    t.boolean  "enable_sms",   default: true
    t.boolean  "enable_email", default: true
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "fullname"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "fb_image"
    t.string   "phone_number"
    t.text     "description"
    t.string   "pin"
    t.boolean  "phone_verified"
    t.string   "stripe_id"
    t.integer  "unread",                 default: 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
