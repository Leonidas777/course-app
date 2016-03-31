require 'sidekiq/web'

Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  mount Sidekiq::Web, at: '/sidekiq'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  namespace :api do
    namespace :v1 do
      resources :courses, only: :index
      resources :auth_tokens, only: :create

      scope 'user/self', as: 'user', module: 'user' do
        resources :courses, only: :index
        resources :subscribed_courses, only: :index
      end
    end
  end

  resources :courses, only: [:index, :show] do
    resources :participants, only: [:index, :destroy]
    resource  :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
    resources :visible_lessons, only: [:create, :destroy], controller: :visible_lessons
    resources :lessons, only: [:index, :show]
  end

  namespace :users do
    resource  :profile, only: [:edit, :update], controller: :profile
    resources :courses
    resources :course_blocked_users, only: [:create]
    resources :lessons do
      resources :homeworks, only: [:new, :create, :show, :destroy]
    end
    resources :subscribed_courses, only: [:index]

    resources :activities, only: :index
    resources :received_homeworks, only: :index

    resources :homeworks_handling, only: [:create, :destroy], controller: :homeworks_handling
  end

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
