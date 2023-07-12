Rails.application.routes.draw do
  scope :api do
    post 'users/login', to: 'authentication#login'
    # ユーザーのログインを処理するためのルート
    get 'articles/:slug', to: 'articles#show'
    # 記事の表示を処理するためのルート
    resources :users, only: [:create, :show, :update, :destroy]
    # ユーザーの作成、表示、更新、削除を処理するためのルート
    resources :articles, param: :slug, only: [:index, :show, :create, :destroy, :update]
    # 記事の作成を処理するためのルート（パラメーターとしてスラッグを使用）

    post "/sign_in", to: "sessions#create"

    scope :profiles do
      # 以下のルートは/profilesの下にある
      get ':username', to: 'profiles#show'
      # プロフィールの表示を処理するためのルート
      post ':username/follow', to: 'profiles#follow'
      # プロフィールのフォローを処理するためのルート
      delete ':username/follow', to: 'profiles#unfollow'
      # プロフィールのフォロー解除を処理するためのルート
    end

    namespace :api do # 以下のルートは/apiの下にある
      resources :articles, only: [:index] # 既存のルート
      get 'articles/custom', to: 'articles#custom' # 新しいルート
    end
  end

  put 'articles/:slug', to: 'articles#update'
  # 記事の更新を処理するためのルート
end
