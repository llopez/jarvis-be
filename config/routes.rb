Rails.application.routes.draw do
  get 'nodes' => 'nodes#index'
  get 'nodes/:id' => 'nodes#show'

  get 'things' => 'things#index'
  get 'things/:id' => 'things#show'

  post 'auth' => 'auths#create'
end
