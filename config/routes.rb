Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :shelters
  resources :pets
  get 'shelters/:id/pets', to: 'shelters#pets'
end
