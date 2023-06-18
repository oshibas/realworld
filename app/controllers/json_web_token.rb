require 'jwt'

module JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s # Railsのシークレットキーを取得

  # トークンのエンコード
  def self.encode(payload, exp = 48.hours.from_now)
    # payload[:exp] = exp.to_i # 有効期限を設定
    JWT.encode(payload, SECRET_KEY) # ペイロード（データの本体=user idのjsonデータ）とシークレットキーを使用してトークンをエンコード,引数で秘密鍵を渡す
  end

  # トークンのデコード
  def self.decode(token)
    decode = JWT.decode(token, SECRET_KEY)[0] # トークンをデコード
    HashWithIndifferentAccess.new decode # デコードしたトークンをハッシュに変換
  end
end
