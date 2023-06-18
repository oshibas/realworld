class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email  # メールアドレス
      t.string :username  # ユーザー名
      t.string :password_digest  # パスワードのハッシュ化
      t.string :image  # 画像
      t.text :bio  # プロフィール

      t.timestamps
    end

    add_index :users, :email, unique: true  # メールアドレスに対するインデックスの追加
    change_column_null :users, :email, false  # メールアドレスのnull制約の追加
    change_column_null :users, :username, false  # ユーザー名のnull制約の追加
    change_column_null :users, :password_digest, false  # パスワードのハッシュ化のnull制約の追加
  end
end
