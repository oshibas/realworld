class UsersController < ApplicationController # UsersControllerを作成し、ApplicationControllerを継承する
  skip_before_action :authorize_request, only: :create # ユーザーの作成の場合はリクエストの認可をスキップする

  def create # ユーザーの作成
    @user = User.new(user_params)

    if @user.save # ユーザーの保存に成功した場合
      render json: @user.as_json, status: :created # 保存に成功した場合はユーザーをJSON形式でレスポンスとして返す
    else # ユーザーの保存に失敗した場合
      render json: {errors: @user.errors }, status: :unprocessable_entity # 保存に失敗した場合はエラーメッセージをJSON形式でレスポンスとして返す
    end
  end

  private

  def user_params # ユーザーのパラメーターを取得するメソッド
    params.require(:user).permit(:email, :username, :password, :image, :bio)
  end
end
