Jambox::Application.routes.draw do

  get "dropbox/authorize"

  match "dropbox/:path/upload_sample" => 'dropbox#upload_sample'
  
  get "dropbox/index"
  get "dropbox" => 'dropbox#index'
  post "dropbox/jam"
  post "dropbox/create"
  
  match 'dropbox/:path' => 'dropbox#dir'
  match 'dropbox/:path/download' => 'dropbox#download'
  
  root :to => "welcome#index"

end
