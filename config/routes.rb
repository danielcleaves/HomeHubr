Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  resources :users, only: [:show] do
    member do
      post '/verify_phone_number' => 'users#verify_phone_number'
      patch '/update_phone_number' => 'users#update_phone_number'
    end
  end

  resources :conversations, only: %i[index create] do
    resources :messages, only: %i[index create]
  end

  resources :houses, except: [:edit] do
    member do
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'amenities'
      get 'location'
      get 'publish'
      get 'unpublish'
    end
    resources :photos, only: %i[create destroy]
    resources :bookings, only: [:create]
  end

  get '/your_leads' => 'bookings#your_leads'

  get '/add_phone_number' => 'users#add_phone_number'
  # post '/new_phone' => 'users#add_phone_number'

  get '/houses' => 'houses#index'

  get 'about' => 'pages#about'

  get 'contact' => 'pages#contact'
  post 'contact' => 'pages#contact_us'

  get 'terms' => 'pages#terms'

  get 'company' => 'pages#company'

  get 'search' => 'pages#search'

  get 'dashboard' => 'dashboards#index'


  get '/payment_method' => 'users#payment'
  post '/add_card' => 'users#add_card', as: 'add_card'
  post '/remove_card' => 'users#remove_card', as: 'remove_card'

  get '/notification_settings' => 'settings#edit'
  post '/notification_settings' => 'settings#update'

  get '/notifications' => 'notifications#index'

  mount ActionCable.server => '/cable'
end
