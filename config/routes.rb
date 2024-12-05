Rails.application.routes.draw do
  root "pages#index"

  # resources :pages, only: [ :show ]
  get "about", to: "pages#about"
  get "contact", to: "pages#contact"

  # products and buy now paths
  resources :products, only: [ :index, :show ] do
    resource :buy_now, only: [ :show, :create ], controller: :buy_now do
      get "success"
    end
  end
  resources :categories, only: [] do
    resources :products, only: :index
  end

  # cart
  resources :carts, only: [ :create, :show ] do
    get "checkout", on: :member, to: "carts#checkout"
    post "stripe_session", on: :member, to: "carts#stripe_session"
    get "success", on: :member, to: "carts#success"
  end


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
