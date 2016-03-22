Rails.application.routes.draw do
   resources :events do
    resources :participants do
      get '/join_subscription', to: 'participants#set_agreement_to_true', defaults: {format: 'html'}
    end
    get '/participant_form', to: 'events#form_data', defaults: { format: 'json'}
    post '/participant_form', to: 'participants#receive_form', defaults: { format: 'json' }
    get '/refresh_statuses', to: 'participant#refresh_statuses', defaults: { format: 'json' }
    delete '/participant_set_status_deleted_and_notify/:id', to: 'participants#set_status_deleted_and_notify', defaults: { format: 'json' }, as: :participant_delete_and_notify
    delete '/participant_set_status_deleted/:id', to: 'participants#set_status_deleted', defaults: { format: 'json' }, as: :participant_delete
    patch '/participant_set_paid_and_notify/:id', to: 'participants#set_paid_and_notify', defaults: { format: 'json' }, as: :participant_set_paid_and_notify
    patch '/participant_set_arrived/:id', to: 'participants#set_arrived', defaults: { format: 'json' }, as: :participant_set_arrived
    get '/calculate_participance_cost', to: 'participants#calculate_participance_cost', defaults: { format: 'json' }, as: :participant_calculate_cost

    get '/dashboard', to: 'dashboard#index', as: :dashboard
  end

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create', as: :session
  delete 'logout', to: 'sessions#destroy', as: :logout

  root to: 'application#redirect_to_events_list'
end
