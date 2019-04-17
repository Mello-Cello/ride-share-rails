Rails.application.routes.draw do
  get 'passengers/index'
  get 'passengers/new'
  get 'drivers/index'
  get 'drivers/new'
  get 'trips/index'
  # add other routes later if needed
  resources :trips, :drivers, :passengers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
