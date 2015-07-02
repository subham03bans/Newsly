Rails.application.routes.draw do
  get 'news/index'

  match "news/create" => "news#create", :via => :post
  
  get "news/sports" 
  get "news/business" 
  get "news/technology" 
  get "news/entertainment" 

  match "news/search" => "news#search", :via => :post
  match "news/autocomplete" => "news#autocomplete", :via => :get
  match "news/comments" => "news#comments", :via => :post
  get "news/vote"
  match "news/vote" => "news#vote", :via => :post
  match "news/show_news_details" => "news#show_news_details", :via => :get

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'news#index'

  match 'sessions/create' => "sessions#create", :via => :get
  match 'sessions/destroy' => "sessions#destroy", :via => :get

#  get 'sessions/destroy'

#-----Google Authentication  : 
    get 'auth/:provider/callback', to: 'sessions#create'
    get 'auth/failure', to: redirect('/')
    get 'signout', to: 'sessions#destroy', as: 'signout'

    resources :sessions, only: [:create, :destroy]
    resource :home, only: [:show]


#------- Google Authentication End

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
