Rails.application.routes.draw do
  # TODO: review these resources and uncomment them
  # resources :participants do
  #   patch :edit_payment, on: :member, defaults: {format: 'js'}
  #   post :payment_confirm, on: :member
  #   delete :wipe, on: :member
  #   patch :unarchive, on: :member
  #   get :resend_confirmation, on: :member
  #   put :edit_form, on: :member
  #   get :list_mail, on: :member
  #   patch :edit, on: :member
  #   delete :destroy_and_mail, on: :member
  #   patch :set_arrived, on: :member, defaults: {format: 'js'}
  # end

  resources :events do
    resources :participants
    get '/participant_form', to: 'events#form_data', defaults: { format: 'json'}
    post '/participant_form', to: 'participants#receive_form', defaults: { format: 'json' }
    delete '/participant_set_status_deleted_and_notify/:id', to: 'participants#set_status_deleted_and_notify', defaults: { format: 'json' }, as: :participant_delete_and_notify
    patch '/participant_set_paid_and_notify/:id', to: 'participants#set_paid_and_notify', defaults: { format: 'json' }, as: :participant_set_paid_and_notify
  end

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create', as: :session
  get 'logout', to: 'sessions#destroy', as: :logout

  root to: 'application#redirect_to_events_list'
end
