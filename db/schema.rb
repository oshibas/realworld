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
# スキーマ変更を生SQLで記述せずに、Rubyで作成されたマイグレーション用のDSL（ドメイン固有言語）を用いてテーブルの変更を簡単に記述する。
# このファイルは、`bin/rails db:schema:load`を実行すると、Railsがスキーマを定義するために使用するソースです。
ActiveRecord::Schema[7.0].define(version: 0) do
  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.string "description"
    t.text "body"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false # 作成日時カラム: datetime型でnullを許可しない
    t.datetime "updated_at", null: false # 更新日時カラム: datetime型でnullを許可しない
    t.index ["slug"], name: "index_articles_on_slug", unique: true # "slug"カラムに対するユニークインデックス
    t.index ["user_id"], name: "index_articles_on_user_id" # "user_id"カラムに対するインデックス
  end
end
