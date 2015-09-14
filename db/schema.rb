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

ActiveRecord::Schema.define(version: 20150909131613) do

  create_table "addresses", force: :cascade do |t|
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "street"
    t.string   "city"
    t.string   "country"
    t.string   "district"
    t.string   "region"
    t.string   "house_number"
    t.string   "apartment_number"
    t.string   "google_place_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "administrative_user_infos", force: :cascade do |t|
    t.string   "role"
    t.integer  "company_id"
    t.string   "contact_phone_number"
    t.integer  "group_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "agreement_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "html_source"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "apartment_houses", force: :cascade do |t|
    t.integer  "complex_id"
    t.float    "price_from"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "apartment_technical_infos", force: :cascade do |t|
    t.integer  "actable_as_apartment_id"
    t.string   "actable_as_apartment_type"
    t.integer  "level"
    t.string   "world_sides"
    t.string   "apartment_type"
    t.float    "live_square"
    t.string   "building_number"
    t.string   "outer"
    t.text     "exterior_walls"
    t.text     "apartment_separator_walls"
    t.text     "apartment_inner_separator_walls"
    t.float    "height"
    t.string   "filling_openings_in_walls"
    t.text     "telephony"
    t.text     "internet"
    t.text     "tv"
    t.text     "kitchen_stove_type"
    t.text     "wiring"
    t.text     "sanitary_equipment"
    t.text     "heating"
    t.text     "ventilation"
    t.text     "water_supply"
    t.text     "internal_sewer_system"
    t.text     "internal_finishing_work"
    t.text     "additional_info"
    t.text     "turnkey_apartment"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "apartments", force: :cascade do |t|
    t.integer  "building_complex_fast_link"
    t.integer  "apartment_house_id"
    t.integer  "apartment_number"
    t.float    "price"
    t.float    "square"
    t.string   "status"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assets", force: :cascade do |t|
    t.integer  "assetable_id"
    t.string   "assetable_type"
    t.string   "assetable_field_name"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "building_complexes", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.string   "total_square"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "client_infos", force: :cascade do |t|
    t.date     "birthday"
    t.string   "identification_number"
    t.string   "passport_series"
    t.string   "given_by"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "companyable_type"
    t.integer  "companyable_id"
    t.string   "companyable_field_name"
    t.string   "name"
    t.string   "site"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "house_main_infos", force: :cascade do |t|
    t.integer  "actable_as_house_id"
    t.string   "actable_as_house_type"
    t.string   "house_class"
    t.string   "availability"
    t.date     "end_date"
    t.date     "start_date"
    t.float    "price_from"
    t.string   "builder_site"
    t.string   "phone"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "house_technical_infos", force: :cascade do |t|
    t.integer  "actable_as_house_id"
    t.string   "actable_as_house_type"
    t.integer  "sections_count"
    t.text     "building_type"
    t.float    "earth_area_square"
    t.text     "operated_roof"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "infrastructures", force: :cascade do |t|
    t.integer  "building_id"
    t.string   "building_type"
    t.text     "distance_to_pre_school"
    t.text     "distance_to_school"
    t.text     "distance_to_food_markets"
    t.text     "playground"
    t.text     "nearest_metro_station"
    t.text     "nearest_bus_stop"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seo_tags", force: :cascade do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "title"
    t.text     "keywords"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "sigma_agreements", force: :cascade do |t|
    t.string   "code_number"
    t.datetime "laid_at"
    t.integer  "apartment_id"
    t.integer  "client_id"
    t.integer  "manager_id"
    t.integer  "agreement_template_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "sigma_apartment_houses", force: :cascade do |t|
    t.boolean  "published"
    t.integer  "building_complex_id"
    t.string   "coordinates"
    t.string   "street"
    t.string   "street_number"
    t.string   "status"
    t.date     "building_start_date"
    t.date     "building_end_date"
    t.float    "price_from"
    t.integer  "levels_count"
    t.integer  "apartments_count"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "sigma_apartment_technical_settings", force: :cascade do |t|
    t.string   "building_type"
    t.integer  "building_id"
    t.text     "exterior_walls"
    t.text     "apartment_separator_walls"
    t.text     "apartment_inner_separator_walls"
    t.float    "premises_height"
    t.string   "filling_openings_in_walls"
    t.text     "entrance_door"
    t.text     "windows"
    t.text     "telephony"
    t.text     "internet"
    t.text     "tv"
    t.text     "kitchen_stove_type"
    t.text     "wiring"
    t.text     "sanitary_equipment"
    t.text     "heating"
    t.text     "ventilation"
    t.text     "water_supply"
    t.text     "internal_sewer_system"
    t.text     "internal_finishing_work"
    t.text     "additional_info"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "sigma_apartments", force: :cascade do |t|
    t.boolean  "published"
    t.integer  "building_complex_id"
    t.integer  "apartment_house_id"
    t.string   "apartment_number"
    t.integer  "price"
    t.string   "building_premise_number"
    t.string   "world_sides"
    t.string   "apartment_type"
    t.string   "live_square"
    t.text     "turnkey"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "rooms_count"
    t.text     "html_description"
    t.datetime "price_approved_at"
    t.integer  "level"
    t.text     "infrastructure_description_html"
    t.text     "main_description_html"
  end

  create_table "sigma_builders", force: :cascade do |t|
    t.string   "name"
    t.string   "site"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sigma_building_complexes", force: :cascade do |t|
    t.string   "name"
    t.string   "complex_class"
    t.string   "coordinates"
    t.string   "country"
    t.string   "city"
    t.string   "district"
    t.string   "street"
    t.string   "street_number"
    t.string   "status"
    t.string   "availability"
    t.date     "building_start_date"
    t.date     "building_end_date"
    t.integer  "houses_count"
    t.float    "price_from"
    t.string   "phone"
    t.text     "distance_to_pre_school"
    t.text     "distance_to_school"
    t.text     "distance_to_food_markets"
    t.text     "playground"
    t.text     "nearest_metro_station"
    t.text     "nearest_bus_stop"
    t.float    "earth_area_square"
    t.float    "total_complex_square"
    t.float    "total_live_square"
    t.integer  "total_accommodations_count"
    t.float    "commerce_square_of_residential_premises"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.text     "main_description_html"
    t.text     "short_description"
    t.string   "site"
    t.integer  "builder_id"
    t.text     "infrastructure_description_html"
  end

  add_index "sigma_building_complexes", ["builder_id"], name: "index_sigma_building_complexes_on_builder_id"

  create_table "sigma_house_technical_settings", force: :cascade do |t|
    t.string   "building_type"
    t.integer  "building_id"
    t.text     "operated_roof"
    t.text     "building_process_type"
    t.integer  "sections_count"
    t.string   "lift_mark"
    t.text     "devices_setup"
    t.text     "beautification"
    t.text     "video_surveillance_system"
    t.string   "parking_type"
    t.integer  "park_places_count"
    t.text     "apply_energy_saving_technologies"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "sigma_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
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
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "username"
    t.boolean  "subscribe"
  end

  add_index "sigma_users", ["email"], name: "index_sigma_users_on_email", unique: true
  add_index "sigma_users", ["invitation_token"], name: "index_sigma_users_on_invitation_token", unique: true
  add_index "sigma_users", ["invitations_count"], name: "index_sigma_users_on_invitations_count"
  add_index "sigma_users", ["invited_by_id"], name: "index_sigma_users_on_invited_by_id"
  add_index "sigma_users", ["reset_password_token"], name: "index_sigma_users_on_reset_password_token", unique: true

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
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
