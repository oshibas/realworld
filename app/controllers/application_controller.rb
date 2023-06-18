class ApplicationController < ActionController::API # ActionController::APIを継承する
  include JsonWebToken # JsonWebTokenモジュールを読み込む

  before_action :authorize_request # リクエストの認可を行うメソッド

  # リクエストの認可を行うメソッド
  def authorize_request
    header = request.headers['Authorization'] # リクエストヘッダーからAuthorizationを取得する
    token = header.split(' ').last if header # Authorizationの値をスペースで分割して、最後の値を取得する

    begin
      @decoded = JsonWebToken.decode(token) # { user_id: 10}のような形に戻す
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

  # 例外（認可に失敗した場合）に返すエラーレスポンス'Unauthorized'を生成するメソッド
  def render_unauthorized
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end
