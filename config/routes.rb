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
  resources :data_lists 

  match 'broken_data_sources' => 'dashboards#broken_data_sources'
  match 'search_data_sources' => 'dashboards#search_data_sources'
  match 'send_prognoz_export' => 'prognoz_data_files#send_prognoz_export'
  match 'investigate' => 'dashboards#investigate'
  match 'investigate_visual' => 'dashboards#investigate_visual'
  match 'investigate_no_source' => 'dashboards#investigate_no_source'
  match 'rake_report' => 'dashboards#rake_report'
  match 'construction' => 'dashboards#construction'
  match 'construction/years/:num_years' => 'dashboards#construction'
  match 'construction_q' => 'dashboards#construction_quarterly'
  match 'construction_q/years/:num_years' => 'dashboards#construction_quarterly'
  match 'hbr_mbr' => 'dashboards#hbr_mbr'
  match 'hbr_mbr/years/:num_years' => 'dashboards#hbr_mbr'
  match 'permits' => 'dashboards#permits'
  match 'permits/years/:num_years' => 'dashboards#permits'
  match 'prudential' => 'dashboards#prudential'
  match 'prudential/years/:num_years' => 'dashboards#prudential'

  match 'employment' => 'dashboards#employment'
  match 'employment/years/:num_years' => 'dashboards#employment'
  match 'employment_us' => 'dashboards#employment_us'
  match 'employment_us/years/:num_years' => 'dashboards#employment_us'
  match 'employment_hon' => 'dashboards#employment_hon'
  match 'employment_hon/years/:num_years' => 'dashboards#employment_hon'
  match 'employment_mau' => 'dashboards#employment_mau'
  match 'employment_mau/years/:num_years' => 'dashboards#employment_mau'
  match 'employment_haw' => 'dashboards#employment_haw'
  match 'employment_haw/years/:num_years' => 'dashboards#employment_haw'
  match 'employment_kau' => 'dashboards#employment_kau'
  match 'employment_kau/years/:num_years' => 'dashboards#employment_kau'

  match 'income' => 'dashboards#income'
  match 'income_r' => 'dashboards#income_r'

  match 'tax_m' => 'dashboards#tax_m'
  

  match 'visitor' => 'dashboards#visitor_hi_m'
  match 'visitor_hon' => 'dashboards#visitor_hon_m'
  match 'visitor_mau' => 'dashboards#visitor_mau_m'
  match 'visitor_haw' => 'dashboards#visitor_haw_m'
  match 'visitor_kau' => 'dashboards#visitor_kau_m'
  
  match 'visitor_q' => 'dashboards#visitor_hi_q'
  match 'visitor_hon_q' => 'dashboards#visitor_hon_q'
  match 'visitor_mau_q' => 'dashboards#visitor_mau_q'
  match 'visitor_haw_q' => 'dashboards#visitor_haw_q'
  match 'visitor_kau_q' => 'dashboards#visitor_kau_q'

  match 'visitor_a' => 'dashboards#visitor_hi_a'
  match 'visitor_hon_a' => 'dashboards#visitor_hon_a'
  match 'visitor_mau_a' => 'dashboards#visitor_mau_a'
  match 'visitor_haw_a' => 'dashboards#visitor_haw_a'
  match 'visitor_kau_a' => 'dashboards#visitor_kau_a'

  match 'prudential_list_q' => 'dashboards#prudential_list_q'
  
  match 'mapping' => 'dashboards#mapping'
  match 'cache' => 'dashboards#d_cache'

  match 'listseries/search' => 'listseries#search'
  match 'listseries/re' =>'listseries#redir'
  match 'listseries/:name' => 'listseries#get'
  
  match 'autocomplete' => 'series#autocomplete_search'
  
  #match 'path' => 'controller#method'
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
