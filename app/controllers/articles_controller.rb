class ArticlesController < ApplicationController

  before_action :authorize_request # リクエストの認可を行うメソッド
  before_action :set_article, only: [:show, :update, :destroy] # 記事の取得を行うメソッド

  def index # 記事の一覧
    @articles = Article.all # 全ての記事を取得する
    render json: { articles: @articles.as_json } # 記事をJSON形式でレスポンスとして返す
  end

  def create # 記事の作成
    @article = @current_user.articles.new(article_params) # ログインしているユーザーに紐付いた記事を作成する

    if @article.save # 記事の保存に成功した場合
      render json: @article # 保存に成功した場合は記事をJSON形式でレスポンスとして返す
    else
      render json: @article.errors, status: :unprocessable_entity # 保存に失敗した場合はエラーメッセージをJSON形式でレスポンスとして返す
    end
  end

  def show # 記事の詳細
    render_article # 記事をJSON形式でレスポンスとして返す
  end

  def update # 記事の更新
    unless owner?(@article) # 記事の所有者でない場合はエラーレスポンスを返す
      render json: { error: "Unauthorized" }, status: :unauthorized # 例外（認可に失敗した場合）に返すエラーレスポンス'Unauthorized'を生成するメソッド
    end

    if @article.update(article_params) # 記事の更新に成功した場合は記事をJSON形式でレスポンスとして返す
      render_article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy # 記事の削除
    unless owner?(@article) # 記事の所有者でない場合はエラーレスポンスを返す
      render_unauthorized # 例外（認可に失敗した場合）に返すエラーレスポンス'Unauthorized'を生成するメソッド
    end

      @article.destroy # 記事の削除に成功した場合は記事をJSON形式でレスポンスとして返す
    end

  private # 以下のメソッドはクラス外から呼び出せない

  def set_article # 記事のidを取得するメソッド
    @article = Article.find_by_slug(params[:id]) # 記事のidを取得する
  end

  def article_params # 記事のパラメーターを取得するメソッド
    params.require(:article).permit(:title, :description, :body)
  end

  def render_article(user = nil)
    render json: { articles: @article.as_json } # 記事をJSON形式でレスポンスとして返す
  end
end
