require 'jwt'

module JsonWebToken
  # トークンのエンコード
  def self.encode(payload)
    JWT.encode(payload, 'your_secret_key') # ペイロードとシークレットキーを使用してトークンをエンコード
  end

  # トークンのデコード
  def self.decode(token)
    JWT.decode(token, 'your_secret_key')[0] # トークンとシークレットキーを使用してデコードされたペイロードを取得
  end
end
