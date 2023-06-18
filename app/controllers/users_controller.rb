class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json, status: :created # 保存に成功した場合はユーザーをJSON形式でレスポンスとして返す
    else
      render json: {errors: @user.errors }, status: :unprocessable_entity # 保存に失敗した場合はエラーメッセージをJSON形式でレスポンスとして返す
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :image, :bio)
  end
end
