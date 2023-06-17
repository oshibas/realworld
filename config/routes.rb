Rails.application.routes.draw do
  scope :api do
    post 'users/login', to: 'authentication#login' # ユーザーのログインを処理するためのルート
    resources :users, only: [:create, :show, :update, :destroy] # ユーザーの作成、表示、更新、削除を処理するためのルート
    resources :articles, param: :slug, only: %i[create] # 記事の作成を処理するためのルート（パラメーターとしてスラッグを使用）
    post '/api/articles', to: 'articles#create' # 記事の作成を処理するためのルート
  end
end
