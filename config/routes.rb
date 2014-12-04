Rails.application.routes.draw do
  devise_for :users
  resources :balance

  resources :bank do
    collection do
      get :select
      get :reload
      get :convert
      post :build
    end
  end

  resources :natural_people do 
    collection do 
      get :send_email
      get :multiple_email_send
      get :send_sms
    end
  end
  resources :legal_people do
    collection do
      get :send_email
      get :multiple_email_send
      get :send_sms
    end
  end
  resources :people, only: :index

  root to: 'people#index'
end
