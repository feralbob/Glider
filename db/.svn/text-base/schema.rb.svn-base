# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100119003535) do

  create_table "chain_exits", :force => true do |t|
    t.integer  "chain_id",      :limit => 8
    t.integer  "chain_exit_id", :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chain_vote_tokens", :force => true do |t|
    t.integer  "chain_id",   :limit => 8
    t.text     "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chains", :force => true do |t|
    t.boolean  "presenting",               :default => false, :null => false
    t.boolean  "presented",                :default => false, :null => false
    t.text     "description"
    t.integer  "votes",       :limit => 8, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entrypoints", :force => true do |t|
    t.integer  "chain_id",   :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_vote_tokens", :force => true do |t|
    t.integer  "question_id", :limit => 8
    t.text     "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "votes",      :limit => 8, :default => 0
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slides", :force => true do |t|
    t.integer  "slide_id",             :limit => 8
    t.integer  "slide_build_id",       :limit => 8
    t.integer  "sequence_id",          :limit => 8
    t.integer  "original_sequence_id", :limit => 8
    t.integer  "chain_id",             :limit => 8
    t.binary   "png",                  :limit => 16777215
    t.binary   "png_large_preview",    :limit => 16777215
    t.binary   "png_small_preview"
    t.boolean  "presenting",                               :default => false, :null => false
    t.boolean  "presented",                                :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slides", ["chain_id"], :name => "index_slides_on_chain_id"
  add_index "slides", ["id"], :name => "index_slides_on_id"
  add_index "slides", ["original_sequence_id"], :name => "index_slides_on_original_sequence_id"
  add_index "slides", ["sequence_id"], :name => "index_slides_on_sequence_id"
  add_index "slides", ["slide_id"], :name => "index_slides_on_slide_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
