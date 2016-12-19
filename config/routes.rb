Rails.application.routes.draw do
    root to: 'pages#home'
    devise_for :users, controllers: { registrations: 'users/registrations' }
    resources :users do
        resource :profile
    end
    get 'about', to: 'pages#about'
    get 'jobs', to: 'pages#jobs'
    resources :contacts, only: :create
    get 'contact-us', to: 'contacts#new', as: 'new_contact'
end