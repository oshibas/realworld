# class User < ActiveRecord::Base
#   has_secure_password
# end

FactoryBot.define do
  factory :user do
    name { "John Doe" }
    # 他の属性の定義
  end
end
