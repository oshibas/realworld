class ArticlesController < ApplicationController
  def create
    @article = @current_user.articles.new(article_params)

    if @article.save
      render json: @article # 保存に成功した場合は記事をJSON形式でレスポンスとして返す
    else
      render json: @article.errors, status: :unprocessable_entity # 保存に失敗した場合はエラーメッセージをJSON形式でレスポンスとして返す
    end
  end

  def show
    render_article
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end

  def render_article
    render json: { articles: @article.as_json } # 記事をJSON形式でレスポンスとして返す
  end
end
