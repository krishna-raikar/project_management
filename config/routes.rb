Rails.application.routes.draw do
  

  get 'projects/:id/overview' => "projects#overview", as: :overview
  get '/dashboard' => "promax#dashboard", as: :dashboard
  get '/attachments' => "attachments#show_all" , as: :attachments

  root "promax#welcome"
  get '/promax'=>"promax#index"



  get "promax/autocomplete_project_pname" => "promax#autocomplete_project_pname"


  resources :attachments
  # get 'attachments/index'

  # get 'attachments/new'

  # get 'attachments/show'

  # get 'attachments/edit'

  # get 'attachment/index'

  # get 'attachment/show'

  # get 'attachment/edit'

  # get 'attachment/new'

  get 'errors/not_found'

  get 'errors/internal_server_error'

  get 'errors/unauth_access'


  #for showing dynamic error messages
  get "/404" => "errors#not_found"
  get "/401" => "errors#unauth_access"
  get "/500" => "errors#internal_server_error"

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
  
  # unauthenticated :user do
  #   root "devise/sessions#new"
  # end

  # authenticated :user do
  #   root "promax#index"
  # end

  # get "/issues/view" => "issues#view_filter"

  devise_for :users,path_prefix: 'd'

    


  resources :users,only:[:index,:show,:edit,:update,:destroy]
  
  resources :projects do
    resources :tasks
    resources :issues
    resources :attachments,except: [:new]
    resources :project_users
  end
  
  resources :roles
  resources :permissions
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  
  # root to: "promax#index"
  # root "promax#index"
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
