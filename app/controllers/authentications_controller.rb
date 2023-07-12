class AuthenticationsController < ApplicationController
  skip_before_action :authorize_request, only: :login
  # ログイン処理の場合はリクエストの認可をスキップする

  def login
    @user = User.find_by(email: params[:user][:email])

    if @user&.authenticate(params[:user][:password])
      # authenticateはRailsのメソッドで、引数のパスワードが正しいかどうかをチェックする。
      # パスワードが正しい場合はJWTトークンを生成して、JSONとして返す。
      @user_token = JsonWebToken.encode(user_id: @user.id)
      render json: @user.to_json(@user_token), status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :image, :bio)
  end
end
