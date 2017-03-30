Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :boards
  root 'boards#index'

  get '/boards/:id/new', to: 'scores#new', as: 'new_score'
  get '/boards/:board_id/:id/edit', to: 'scores#edit', as: 'edit_score'
  post '/boards/:id/new', to: 'scores#create'
  post '/boards/:board_id/:id/edit', to: 'scores#update'
  delete '/boards/:board_id/:id', to: 'scores#destroy', as: 'score'
end
