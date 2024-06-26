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

ActiveRecord::Schema[7.1].define(version: 2024_06_03_152814) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "applied_jobs", force: :cascade do |t|
    t.bigint "job_listing_id", null: false
    t.bigint "talent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.decimal "balance"
    t.index ["job_listing_id"], name: "index_applied_jobs_on_job_listing_id"
    t.index ["talent_id"], name: "index_applied_jobs_on_talent_id"
  end

  create_table "job_listings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "requirements"
    t.decimal "salary"
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.string "status", default: "pending"
    t.index ["owner_id"], name: "index_job_listings_on_owner_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "message_sender_id", null: false
    t.bigint "message_receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_receiver_id"], name: "index_messages_on_message_receiver_id"
    t.index ["message_sender_id"], name: "index_messages_on_message_sender_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "job_listing_id"
    t.bigint "reviewer_id"
    t.bigint "reviewee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_listing_id"], name: "index_reviews_on_job_listing_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "talent_id", null: false
    t.bigint "job_listing_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_transactions_on_client_id"
    t.index ["job_listing_id"], name: "index_transactions_on_job_listing_id"
    t.index ["talent_id"], name: "index_transactions_on_talent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.float "wallet"
    t.string "resume"
    t.text "skills"
    t.text "experience"
    t.text "education"
    t.string "photo"
    t.string "professional_title"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "applied_jobs", "job_listings"
  add_foreign_key "applied_jobs", "users", column: "talent_id"
  add_foreign_key "job_listings", "users", column: "owner_id"
  add_foreign_key "messages", "users", column: "message_receiver_id"
  add_foreign_key "messages", "users", column: "message_sender_id"
  add_foreign_key "reviews", "job_listings"
  add_foreign_key "reviews", "users", column: "reviewee_id"
  add_foreign_key "reviews", "users", column: "reviewer_id"
  add_foreign_key "transactions", "job_listings"
  add_foreign_key "transactions", "users", column: "client_id"
  add_foreign_key "transactions", "users", column: "talent_id"
  add_foreign_key "users", "roles"
end
