class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :slug # スラッグ
      t.string :title # タイトル
      t.string :description # 説明
      t.text :body # 本文
      t.references :user, foreign_key: true # ユーザーへの外部キー参照

      t.timestamps
    end

    add_index :articles, :slug # スラッグに対するインデックスの追加
  end
end
