UheroDb::Application.routes.draw do
  root :to => "series#index"
  
  devise_for :users

  # get "prognoz_data_files/index"
  # 
  # get "prognoz_data_files/new"
  # 
  # get "prognoz_data_files/show"
  # 
  # get "prognoz_data_files/edit"
  # 
  # get "prognoz_data_files/create"
  # 
  # get "prognoz_data_files/update"
  # 
  # get "prognoz_data_files/destroy"
  # 
  # get "prognoz_data_files/load_from_file"
  # 
  # get "prognoz_data_files/write_xls"
  # 
  # get "data_sources/source"
  # 
  # get "data_sources/delete"
  # 
  # get "data_sources/new"
  # 
  # get "data_sources/create"
  # 
  # get "data_source_downloads/index"
  # 
  # get "data_source_downloads/new"
  # 
  # get "data_source_downloads/show"
  # 
  # get "data_source_downloads/edit"
  # 
  # get "data_source_downloads/update"
  # 
  # get "data_source_downloads/destroy"
  # 
  # get "data_source_downloads/download"
  # 
  # get "data_source_downloads/test_url"
  # 
  # get "data_source_downloads/test_save_path"
  # 
  # get "data_source_downloads/test_post_params"
  # 
  # get "dashboards/index"

  #map.devise_for :users
  
  resources :series
  
  resources :data_source_downloads
  resources :data_sources
  resources :prognoz_data_files
  resources :series_data_files
  resources :dashboards
  
  match 'investigate' => 'dashboards#investigate'
  match 'mapping' => 'dashboards#mapping'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
