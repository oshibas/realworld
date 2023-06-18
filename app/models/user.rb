class User < ApplicationRecord # ユーザーモデルを作成する
  has_secure_password # パスワードをハッシュ化するためのメソッド

  has_many :articles, dependent: :destroy # ユーザーが削除された場合は、そのユーザーが作成した記事も削除する

  validates :username, :email, :password, presence: true # ユーザー名、メールアドレス、パスワードが空でないことを検証する
  validates :email, :username, uniqueness: true, on: :create # ユーザー名、メールアドレスが一意であることを検証する

  def to_json(token = nil)
    {
      { 'user' => as_json(only: %i[email username bio image]) }.merge({ token: })} : {
    }
  end
end
