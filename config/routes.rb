Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admins, except: :show
  resources :boards do
    resources :scores, except: [:index, :show]
  end
  resources :missions do
    resources :assignments, except: [:index, :show]
  end
  resources :teams
  resources :users, except: :show
  resources :photos, except: [:edit, :update] do
    resources :captions, only: [:edit, :update]
  end
  root 'users#login'

  # ------ Admins ------
  get '/admin/home', to: 'admins#home', as: 'home_admin'
  get '/admin/login', to: 'admins#login', as: 'login_admin'
  get '/admin/logout', to: 'admins#logout', as: 'logout_admin'
  post '/admin/login', to: 'admins#create_login'

  # ------ Boards ------
  get '/admin/boards/:id', to: 'boards#admin_show', as: 'admin_board'

  # ------ Captions ------
  get '/admin/photos/:photo_id/captions/:id/edit',
      to: 'captions#admin_edit', as: 'admin_edit_caption'
  patch '/admin/photos/:photo_id/captions/:id',
        to: 'captions#admin_update', as: 'admin_caption'
  post '/admin/photos/:photo_id/captions/:id',
       to: 'captions#admin_update'

  # ------ Missions ------
  get '/admin/missions/:id', to: 'missions#admin_show', as: 'admin_mission'

  # ------ Photos ------
  get '/admin/photos', to: 'photos#admin_index', as: 'admin_photos'
  get '/admin/photos/new', to: 'photos#admin_new', as: 'admin_new_photo'
  get '/admin/photos/:id', to: 'photos#admin_show', as: 'admin_photo'
  post '/admin/photos', to: 'photos#admin_create'
  delete '/admin/photos/:id', to: 'photos#admin_destroy'

  # ------ Teams ------
  get '/team', to: 'teams#home', as: 'home_team'

  # ------ Users ------
  get '/home', to: 'users#home', as: 'home_user'
  get '/login', to: 'users#login', as: 'login_user'
  get '/logout', to: 'users#logout', as: 'logout_user'
  post '/login', to: 'users#create_login'
end
