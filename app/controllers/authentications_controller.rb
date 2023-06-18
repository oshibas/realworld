class AuthenticationsController < ApplicationController
  skip_before_action :authorize_request, only: :login

  def login
    @user = User.find_by email:(params[:user][:email])

    if @user&.authenticate(params[:user][:password]) # authenticateはrailsのメソッドで、引数のパスワードが正しいかどうかをチェックする
      @user_token = JsonWebToken.encode(user_id: @user.id)
      render json: @user.to_json(@user_token), status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def user_params
    params.require(:user).permit(:email, :username, :password, :image, :bio)
  end
end
