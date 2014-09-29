Rails.application.routes.draw do
  resources :balance

  resources :bank do
    collection do
      get :select
      get :reload
      get :convert
      post :build
    end
  end
end
