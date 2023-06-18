class User < ApplicationRecord
  has_secure_password

  has_many :articles, dependent: :destroy

  validates :username, :email, :password, presence: true
  validates :email, :username, uniqueness: true, on: :create

  def to_json(token = nil)
    {
      { 'user' => as_json(only: %i[email username bio image]) }.merge({ token: })} : {
    }
  end
end
