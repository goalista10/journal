Rails.application.routes.draw do
  devise_for :users , controllers: {
    sessions: 'users/sessions'
  }
  resources :categories do
    resources :tasks
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "home/homepage"
  root "home#homepage"
end
