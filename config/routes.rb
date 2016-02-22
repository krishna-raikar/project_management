Rails.application.routes.draw do
  
  # get 'tasks/index'

  # get 'tasks/new'

  # get 'tasks/edit'

  # get 'tasks/destroy'

  # get 'project_users/index'

  # get 'project_users/show'

  # get 'project_users/edit'

  # get 'project_users/destroy'

  # get 'permissions/index'

  # get 'permissions/show'

  # get 'permissions/new'

  # get 'permissions/edit'

  # get 'roles/index'

  # get 'roles/new'

  # get 'roles/edit'

  # get 'roles/show'

  # get 'issues/index'

  # get 'issues/new'

  # get 'issues/edit'

  # get 'issues/show'

  # get 'projects/index'

  # get 'projects/new'

  # get 'projects/create'

  # get 'projects/edit'

  # get 'projects/update'

  # get 'projects/destroy'

  # get 'projects/show'

  # get 'promax_homes/index'


  devise_for :users,path_prefix: 'd'
  resources :users,only:[:index,:show,:edit,:update,:destroy]
  
  resources :projects
  resources :issues
  resources :roles
  resources :permissions
  resources :project_users
  resources :tasks
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: "promax#index"
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
