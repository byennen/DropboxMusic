Jambox::Application.routes.draw do

  resources :requests

  #dashboard
  match 'dashboard' => 'dashboard#index', :as => :dashboard
  match 'invite' => 'welcome#invite', :as => :invite
  
  #upload
  match 'upload' => 'dropbox#dir', :as => :upload

  get "dropbox/authorize"

  match "dropbox/:path/upload_sample" => 'dropbox#upload_sample'
  
  # get "dropbox/index"
  # get "dropbox" => 'dropbox#index'
  post "dropbox/jam"
  post "dropbox/create"
  
  # match 'dropbox/:path' => 'dropbox#dir'
  # match 'dropbox/:path/download' => 'dropbox#download'
  
  root :to => "welcome#index"
end
