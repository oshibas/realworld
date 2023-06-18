class User < ApplicationRecord # ユーザーモデルを作成する
  has_secure_password # パスワードをハッシュ化するためのメソッド

  has_many :articles, dependent: :destroy # ユーザーが削除された場合は、そのユーザーが作成した記事も削除する

  validates :username, :email, :password, presence: true # ユーザー名、メールアドレス、パスワードが空でないことを検証する
  validates :email, :username, uniqueness: true, on: :create # ユーザー名、メールアドレスが一意であることを検証する

  def to_json(token = nil) # ユーザーをJSON形式で返すメソッド
    if token.nil? # ユーザーのトークンがない場合は、ユーザーのみをJSON形式で返す
      { 'user' => as_json(only: %i[email username bio image]) }
    else # ユーザーのトークンがある場合は、ユーザーとトークンをJSON形式で返す
      { 'user' => as_json(only: %i[email username bio image]), token: token }
    end
  end
end
