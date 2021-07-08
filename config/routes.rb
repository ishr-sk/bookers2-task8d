Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  get 'searches/search'
  get 'relationship/create'
  get 'relationship/destroy'
  
  resources :books, only: [:show, :index, :create, :edit, :update, :destroy] do
    # いいね機能
    resource :favorites, only: [:create, :destroy]
    # コメント機能実装
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:show,:index,:edit,:update] do
    # フォロー・フォロワー機能実装（入れ子）
    resource :relationships, only: [:create, :destroy]
    # フォロー・フォロワー一覧
    get :follows, on: :member 
    get :followers, on: :member
  end

end