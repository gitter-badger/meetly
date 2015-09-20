Rails.application.routes.draw do

  resources :participants do
    patch :edit_payment, on: :member, defaults: {format: 'js'}
    post :payment_confirm, on: :member
    delete :wipe, on: :member
    patch :unarchive, on: :member
    get :resend_confirmation, on: :member
    put :edit_form, on: :member
    get :list_mail, on: :member
    patch :edit, on: :member
    delete :destroy_and_mail, on: :member
    patch :set_arrived, on: :member, defaults: {format: 'js'}
  end

  get '/summary', to: 'participants#summary'
  match '/receive_form' => 'participants#receive_form', via: :post, defaults: {format: 'json'}
  match '/receive_form' => 'participants#receive_form', via: :get, defaults: {format: 'json'}
  match '/role_price_table' => 'roles#role_price_table', via: :get, defaults: {format: 'json'}

  post '/participant_form' => 'participants#receive_form', defaults: { format: 'json' }

  match '/form_data' => 'events#form_data', via: :get, defaults: { format: 'json' }
  get '/archived', to: 'participants#show_archived'

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create', as: :session
  delete 'logout', to: 'sessions#destroy', as: :logout

  root to: 'participants#index'
end
