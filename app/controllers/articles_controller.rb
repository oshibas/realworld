class ArticlesController < ApplicationController
  def create
    @article = @current_user.articles.new(article_params)

    if @article.save
      render json: @article
    else
      render json: @article.errors:
      :unprocessable_entity
    end
end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end

  def rander_article(user = nil)
    render json: { articles: @article.to_json }
  end
end
