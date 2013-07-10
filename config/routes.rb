TibiaSmuggler::Application.routes.draw do

  resources :news, only: [:index, :show] # TODO: Assign proper routes when finished
  resources :worlds, only: [:index] # TODO: Assign proper routes when finished
  resources :users, except: :new
  resources :sessions, only: [:create, :destroy]
  resources :rates, only: [:show]
  resources :orders, only: [:new, :create, :show]

  root to: 'orders#new'

  match '/login',               to: 'sessions#new', as: 'login'
  match '/logout',              to: 'sessions#destroy', via: :delete
  match '/help',                to: 'static_pages#help'
  match '/gold_list',           to: 'worlds#index'
  match '/news/:id/:string',    to: 'news#show', as: 'titled_news'
  match '/referrer/:referrer',  to: 'referrers#save', as: 'refer_to'
  match '/rates/:from_world/:to_world', to: 'rates#show'

end
