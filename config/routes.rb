Rails.application.routes.draw do
  devise_for :users
  root "groups#index"
  resources :groups do
    member do
      post :join
      post :quit
    end

    resources :posts
  end

  # namespace :account do
  #   resource :groups
  # end
  # 把resources写成了resource, 所以报错找不到show action
  namespace :account do
    resources :groups
    resources :posts
  end


end
