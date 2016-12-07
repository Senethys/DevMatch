Rails.application.routes.draw do
    root to: 'pages#home'
    get 'about', to: 'pages#about'
    get 'jobs', to: 'pages#jobs'
    resources :contacts
    get 'contact-me', to: 'contacts#new'
end