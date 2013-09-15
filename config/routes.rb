TibiaSmuggler::Application.routes.draw do

  resources :news, only: [:index, :show]
  resources :worlds, only: [:index]
  resources :users, except: :new
  resources :sessions, only: [:create, :destroy]
  resources :rates, only: [:show]
  resources :orders, only: [:new, :create, :index, :show, :destroy]

  root to: 'orders#new'

  namespace :admin do

    resources :orders, only: [:index]
    resources :news, only: [:new, :create, :index]
    resources :worlds, only: :index
    resources :log_entries, only: :index

    get '', to: 'dashboard#index', as: '/'
    get '/orders/:id/accept',   to: 'orders#accept',    as: 'accept_order'
    get '/orders/:id/complete', to: 'orders#complete',  as: 'complete_order'
    get '/orders/:id/reject/',  to: 'orders#destroy',    as: 'reject_order'
    match '/worlds/:id/toggle_outgoing_lock', to: 'worlds#toggle_outgoing_lock', via: :post
    match '/worlds/:id/toggle_incoming_lock', to: 'worlds#toggle_incoming_lock', via: :post
    match '/worlds/:id/edit_amount', to: 'worlds#edit_amount', via: :post
  end

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
