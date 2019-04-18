Rails.application.routes.draw do

  # WE DIDN'T ADD THESE. COMMENTING THEM OUT UNTIL WE KNOW WE NEED THEM.
  # get 'passengers/index'
  # get 'passengers/new'
  # get 'drivers/index'
  # get 'drivers/new'
  # get 'trips/index'

  # add other routes later if needed

  resources :drivers do
    resources :trips, only: [:index, :new]
  end

  resources :passengers do
    resources :trips, only: [:index, :new]
  end

  resources :trips, :drivers, :passengers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
