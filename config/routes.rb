
ActionController::Routing::Routes.draw do |map|


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  map.connect '/users/edit', :controller => "users", :action => "edit"
  map.connect '/activate/:token', :controller => "users", :action => "activate"
  map.connect '/activate', :controller => "users", :action => "activate"
  map.connect '/activated', :controller => "users", :action => "activated"
  map.connect '/users/reactivate', :controller => "users", :action => "reactivate"
  map.connect '/users/emailed', :controller => "users", :action => "emailed"
  map.connect '/users/forgot', :controller => "users", :action => "forgot"
  map.connect '/users/pwreset', :controller => "users", :action => "pwreset"
  map.connect '/saved', :controller => "users", :action => "saved"
  
  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
  map.admin '/admin', :controller => 'admin'
  map.reset_db '/admin/reset_db', :controller => 'admin', :action => 'reset_db'
  map.login  '/login',  :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.apply '/apply', :controller => "users", :action => "new"
  map.submit '/submit', :controller => "users", :action => 'submit'
  map.status '/status', :controller => "users", :action => "status"
  map.thanks '/thanks', :controller => 'users', :action => 'thanks'
  map.connect '/academic_records/sorry', :controller => 'academic_records', :action => "sorry"
  map.rec_thanks '/rec_thanks', :controller => 'users', :action => 'rec_thanks'
  map.app_thanks '/app_thanks', :controller => 'users', :action => 'app_thanks'
  map.resend_request '/resend_request', :controller => 'users', :action => 'resend_request'
  map.signup  '/signup', :controller => 'users',   :action => 'new'

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products
  map.current_projects '/projects/current', :controller => 'projects', :action => 'current'
  map.resources :projects
  map.resources :users
  map.resource :session

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'welcome'
  
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
