Popeye::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users, only: [:show] do
    resources :body_metrics, only: [:new, :create]
    resources :max_lifts, only: [:new, :create] do
      collection do
        get "summary"
        get "retest"
      end
    end
  end
  root 'home#show'
  get "learn_more" => "home#learn_more"
  get "workout_log" => "workout_results#index", as: :workout_log
  get "store" => "stores#index", as: :store
  get "users/:user_id/dashboard" => "dashboards#index", as: :dashboard

  resources :workouts do
    member do
      get "confirm_delete"
    end
  end
  resources :workout_results
  resources :exercises
  resources :programs do
    member do
      post "make_active"
      get "current_weight_metrics"
      post "update_current_weight_metrics"
    end
  end
  resources :stores, only: [:index] do
    collection do
      get :beginner
      get :intermediate
      get :advanced
      post :copy_to_user
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
