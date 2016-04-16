Rails.application.routes.draw do
  
  get 'welcome/history'
  post 'welcome/history', to:"event#store_event"
  
  get 'welcome/login'
  
  get 'welcome/new_user'
  
  get 'welcome/index'
  
  get 'welcome/destroy'

  get 'welcome/clear_event'

  get 'saved_locations/index'

  get 'users/third_party'
  
  get 'users/new_user'
  
  get 'users/login'
  
  get 'event/tracking'
  
  #post 'event/tracking', to: 'event#tracking'
  
  get 'events/index'
  
  get 'event/live_tracking'
  
  post 'event/live_tracking', to: "event#live_tracking"
  
  get 'event/new'
  
  get 'event/send_mail'
  
  get 'event/select_contacts'
  post 'event/store_contacts'
  
  get 'event/select_destination'
  post 'event/select_destination', to: "event#store_destination"
  
  get 'event/message'
  post "event/store_message"

  get 'event/select_duration'

  get 'event/summary'
  

  get '/auth/:provider/callback', :to => 'welcome#create'
  
  get '/contacts/:provider/callback', :to => 'users#third_party'
  
  post '/event/select_duration', :to => 'event#store_duration'
  
  post '/event/select_duration', :to => 'event#store_duration'
  
  
  root 'welcome#index'
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  
  
  # for google maps
  #get "event/select_destination/geocoding", to: "events#geocoding", as: "geocoding"
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   #root 'topics#index'

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
