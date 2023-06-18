class UsersController < ApplicationController # UsersControllerを作成し、ApplicationControllerを継承する
  skip_before_action :authorize_request, only: [:create, :show] # ユーザーの作成の場合はリクエストの認可をスキップする

  def create # ユーザーの作成
    @user = User.new(user_params)

    if @user.save # ユーザーの保存に成功した場合
      render json: @user.as_json, status: :created # 保存に成功した場合はユーザーをJSON形式でレスポンスとして返す
    else # ユーザーの保存に失敗した場合
      render json: {errors: @user.errors }, status: :unprocessable_entity # 保存に失敗した場合はエラーメッセージをJSON形式でレスポンスとして返す
    end
  end

  def show # ユーザーの詳細
    token = cookies[:token] # リクエストヘッダーからトークンを取得する
    rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('auth/service.key'))) # 秘密鍵の取得

    begin # JWTのデコード
      decoded_token = JWT.decode(token, rsa_private, true, { algorithm: 'RS256' }) # トークンをデコードする
    rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
      return render json: { message: 'Unauthorized' }, status: :unauthorized # トークンのデコードに失敗した場合はエラーメッセージをJSON形式でレスポンスとして返す
    end

    user_id = decoded_token.first["sub"] # デコードしたトークンからユーザーIDを取得する
    user = User.find(user_id) # ユーザーIDからユーザーを取得する

    if user.nil? # ユーザーが見つからない場合
      render json: { message: 'Unauthorized' }, status: :unauthorized # エラーメッセージをJSON形式でレスポンスとして返す
    else # ユーザーが見つかった場合
      render json: { # ユーザーをJSON形式でレスポンスとして返す
        user: {
          id: user.id,
          name: user.name,
          email: user.email
        }
      }, status: :ok # ステータスコードは200を返す
    end
  end


  private

  def user_params # ユーザーのパラメーターを取得するメソッド
    params.require(:user).permit(:email, :username, :password, :image, :bio)
  end
end
