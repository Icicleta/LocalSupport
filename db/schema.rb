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

ActiveRecord::Schema.define(version: 20150502193421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "btree_gist"
  enable_extension "chkpass"
  enable_extension "citext"
  enable_extension "cube"
  enable_extension "dblink"
  enable_extension "dict_int"
  enable_extension "dict_xsyn"
  enable_extension "earthdistance"
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"
  enable_extension "isn"
  enable_extension "ltree"
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "pgrowlocks"
  enable_extension "pgstattuple"
  enable_extension "tablefunc"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"

  create_table "categories", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.integer  "charity_commission_id"
    t.string   "charity_commission_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_organisations", force: :cascade do |t|
    t.integer "category_id"
    t.integer "organisation_id"
  end

  add_index "categories_organisations", ["category_id"], name: "index_categories_organisations_on_category_id", using: :btree
  add_index "categories_organisations", ["organisation_id"], name: "index_categories_organisations_on_organisation_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.string  "name",   limit: 255
    t.boolean "active",             default: false
  end

  create_table "organisations", force: :cascade do |t|
    t.string   "name",            limit: 255, default: "",             null: false
    t.string   "address",         limit: 255, default: "",             null: false
    t.string   "postcode",        limit: 255, default: "",             null: false
    t.string   "email",           limit: 255, default: "",             null: false
    t.text     "description",                 default: "",             null: false
    t.string   "website",         limit: 255, default: "",             null: false
    t.string   "telephone",       limit: 255, default: "",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.text     "donation_info",               default: "",             null: false
    t.boolean  "publish_address",             default: false
    t.boolean  "publish_phone",               default: false
    t.boolean  "publish_email",               default: true
    t.datetime "deleted_at"
    t.string   "type",                        default: "Organisation"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "permalink",    limit: 255
    t.text     "content"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "link_visible",             default: true
  end

  add_index "pages", ["permalink"], name: "index_pages_on_permalink", using: :btree

  create_table "proposed_organisation_edits", force: :cascade do |t|
    t.integer  "organisation_id"
    t.string   "name",            limit: 255, default: "",    null: false
    t.string   "address",         limit: 255, default: "",    null: false
    t.string   "postcode",        limit: 255, default: "",    null: false
    t.string   "email",           limit: 255, default: "",    null: false
    t.text     "description",                 default: "",    null: false
    t.string   "website",         limit: 255, default: "",    null: false
    t.string   "telephone",       limit: 255, default: "",    null: false
    t.text     "donation_info",               default: "",    null: false
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted",                    default: false, null: false
    t.boolean  "archived",                    default: false, null: false
  end

  add_index "proposed_organisation_edits", ["deleted_at"], name: "index_proposed_organisation_edits_on_deleted_at", using: :btree
  add_index "proposed_organisation_edits", ["user_id"], name: "index_proposed_organisation_edits_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                   limit: 255, default: "",    null: false
    t.string   "encrypted_password",      limit: 255, default: ""
    t.string   "reset_password_token",    limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",      limit: 255
    t.string   "last_sign_in_ip",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "superadmin",                          default: false
    t.integer  "organisation_id"
    t.string   "confirmation_token",      limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",       limit: 255
    t.integer  "pending_organisation_id"
    t.string   "invitation_token",        limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type",         limit: 255
    t.datetime "deleted_at"
    t.boolean  "siteadmin",                           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["organisation_id"], name: "index_users_on_organisation_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "volunteer_ops", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "description"
    t.integer  "organisation_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "volunteer_ops", ["organisation_id"], name: "index_volunteer_ops_on_organisation_id", using: :btree

end
