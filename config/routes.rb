TibiaSmuggler::Application.routes.draw do

  resources :news, only: [:index, :show] # TODO: Assign proper routes when finished
  resources :worlds, only: [:index] # TODO: Assign proper routes when finished
  resources :users, except: :new
  resources :sessions, only: [:create, :destroy]
  resources :rates, only: [:show]
  resources :orders, only: [:new, :create, :index, :show, :destroy]

  root to: 'orders#new'

  get '/login',                       to: 'sessions#new', as: 'login'
  match '/logout',                    to: 'sessions#destroy', via: :delete
  get '/help',                        to: 'static_pages#help'
  get '/gold_list',                   to: 'worlds#index'
  get '/news/:id/:string',            to: 'news#show', as: 'titled_news'
  get '/referrer/:referrer',          to: 'referrers#save', as: 'refer_to'
  get '/rates/:from_world/:to_world', to: 'rates#show'
  get '/confirm_order',               to: 'orders#create', as: 'confirm_order'
  get '/worlds/:from_world/:to_world',  to: 'worlds#check_availability'
  get '/orders/:id/confirm_parcel',     to: 'orders#confirm_parcel', as:'confirm_parcel' # TODO: It should be a POST request

end
