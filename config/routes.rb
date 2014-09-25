Rails.application.routes.draw do
  resources :balance

  resources :bank do
    collection do
      get :select
    end
  end
end
