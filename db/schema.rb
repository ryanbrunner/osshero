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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110624000144) do

  create_table "help_requests", :force => true do |t|
    t.integer  "requester_id"
    t.integer  "hero_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  add_index "help_requests", ["hero_id"], :name => "index_help_requests_on_hero_id"
  add_index "help_requests", ["requester_id"], :name => "index_help_requests_on_requester_id"

  create_table "help_responses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "help_request_id"
    t.boolean  "completed"
    t.string   "repository"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "help_responses", ["help_request_id"], :name => "index_help_responses_on_help_request_id"
  add_index "help_responses", ["user_id"], :name => "index_help_responses_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "repository"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "email"
    t.string   "github_url"
    t.string   "token"
  end

end
