Rails.application.routes.draw do

# resources :receipts do
#   get :autocomplete_vendor_name, :on => :collection
# end

  devise_for :users
  ActiveAdmin.routes(self)

  root to: 'home#index'
end
