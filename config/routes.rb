Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  resources :balance
  resources :bank do
    collection do
      get :select
      get :reload
      get :convert
      post :build
    end
  end
  resources :credits do
    collection do
      get :set_kind
      get :contract_field
      get :payment
    end
  end

  authenticated :user, lambda { |u| u.role != 'user' } do
    namespace :admin do
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
      resources :credits do
        member do
          put :create_contract
          put :change_state
        end
        collection do
          get :contract_field
          get :payment
        end
      end
    end
  end
  resources :legal_people, only: [:new,:create,:edit,:update]
  resources :natural_people, only: [:new,:create,:edit,:update]
  
  resources :people, only: :index

  root to: 'people#index'
end
