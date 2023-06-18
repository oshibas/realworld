class SessionsController < ApplicationController # SessionsControllerを作成し、ApplicationControllerを継承する
  skip_before_action :authorize_request, only: :create # ログインの場合はリクエストの認可をスキップする

  # ログイン
  def create
    # ユーザの取得
    user = User.find_by(email: params[:email])&.authenticate(params[:password])

    if user # ユーザが見つかった場合
      # ペイロードの作成
      payload = {
        iss: "example_app", # JWTの発行者
        sub: user.id, # JWTの主体
        exp: (DateTime.current + 14.days).to_i # JWTの有効期限
      }

      begin # JWTの作成
        # 秘密鍵の取得
        rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('auth/service.key')))

        # JWTの作成
        token = JWT.encode(payload, rsa_private, "RS256")

        # JWTをCookieにセット
        cookies[:token] = token
        # cookies[:token] = { value: token, expires: 14.days.from_now, httponly: true }

        render status: :created, body: nil
      rescue => e
        render json: { error: "JWTの作成中にエラーが発生しました" }, status: :internal_server_error
      end
    else # ユーザが見つからない場合
      render json: { error: "認証に失敗しました" }, status: :unauthorized
    end
  end
end
