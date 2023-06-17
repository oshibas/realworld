class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authorize_request

  # リクエストの認可を行うメソッド
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  # モデルの所有者かどうかをチェックするメソッド
  def owner?(model)
    model.user_id == @current_user.id
  end

  # 認可に失敗した場合に返すエラーレスポンスを生成するメソッド
  def render_unauthorized
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end
