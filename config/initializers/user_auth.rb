module UserAuth
  # 必須
  mattr_accessor :token_lifetime # トークンの有効期限
  self.token_lifetime = 2.week

  mattr_accessor :token_audience # トークンの受信者
  self.token_audience = -> { # トークンの受信者は、RailsのアプリケーションURLを使用する
    # あとで作成する
    ENV["APP_URL"]
  }

  mattr_accessor :token_signature_algorithm # トークンの署名アルゴリズム
  self.token_signature_algorithm = "HS256" # HS256は、HMAC-SHA256署名アルゴリズムを使用することを意味する

  mattr_accessor :token_secret_signature_key # トークンの署名キー
  self.token_secret_signature_key = -> { # トークンの署名キーは、Railsのシークレットキーを使用する
    Rails.application.credentials.secret_key_base # Railsのシークレットキーを取得
  }

  mattr_accessor :token_public_key # トークンの公開キー
  self.token_public_key = nil # トークンの公開キーは、使用しない

  mattr_accessor :token_access_key # トークンのアクセスキー
  self.token_access_key = :access_token # トークンのアクセスキーは、:access_token

  mattr_accessor :not_found_exception_class # 例外クラス
  self.not_found_exception_class = ActiveRecord::RecordNotFound
end
