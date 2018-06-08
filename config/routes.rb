Rails.application.routes.draw do
  get 'nodes' => 'nodes#index'
  get 'nodes/:id' => 'nodes#show'

  get 'things' => 'things#index'
  get 'things/:id' => 'things#show'
  patch 'things/:id' => 'things#update'

  post 'auth' => 'auths#create'
end
