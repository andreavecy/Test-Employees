class Db < ActiveRecord::Migration
  def change
    create_table "company", force: :cascade do |t|
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "parent_id"
      t.string   "address"
      t.string   "phone"
    end

    create_table "employee", force: :cascade do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.string   "email"
      t.string   "phone"
      t.string   "mobile"
      t.integer  "company_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
