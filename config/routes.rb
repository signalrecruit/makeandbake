Rails.application.routes.draw do


  namespace :admin do
    root 'application#index'

    get 'users/:user_id/products/user_products', to: 'products#user_products', as: :products_of_user
    
    # get 'shopless_products/add', to: 'shopless_products#add', as: :add_shopless_product
    
    patch 'shops/:id/approve', to: 'shops#approve', as: :approve_shop
    patch 'shops/:id/disapprove', to: 'shops#disapprove', as: :disapprove_shop

    patch 'shops/:shop_id/products/:id/approve', to: 'products#approve', as: :approve_product
    patch 'shops/:shop_id/products/:id/disapprove', to: 'products#disapprove', as: :disapprove_product

    patch 'users/:user_id/shopless_products/:id/approve', to: 'shopless_products#approve', as: :approve_shopless_product
    patch 'users/:user_id/shopless_products/:id/disapprove', to: 'shopless_products#disapprove', as: :disapprove_shopless_product

     get 'users/:user_id/shops/user_shops', to: 'shops#user_shops', as: :seller_shops

    resources :users do 
      member do
        patch :switch_to_buyer
        patch :switch_to_seller
      end
    end
    
    resources :users, only: [] do 
      resources :products, except: [:index]
    end
    
    resources :users, only: [] do 
      resources :shops, except: [:index]
    end

    resources :shops, only: [] do 
      resources :products
    end
    
    resources :users do 
      resources :shopless_products
    end


    resources :products, only: [:index, :show]
    resources :shops, only: [:index, :show, :edit, :update, :destroy]
    resources :shopless_products, except: [:index, :new, :create] do
      member do
        get :add
      end
    end
    resources :orders, only: [:index, :show]
    resources :searches, only: [:show, :new, :create]

    get 'buyers', to: 'users#buyers'
    get 'sellers', to: 'users#sellers'
    delete 'products', to: 'products#remove', as: :remove_product_tag
    delete 'shopless_products', to: 'shopless_products#remove', as: :remove_shopless_product_tag
  end

  get 'my_shops', to: 'shops#my_shops', as: :my_shops
  get 'my_products', to: 'products#my_products', as: :my_products
  get 'categorization', to: "products#categorization"

  delete 'shopless_products', to: 'shopless_products#remove', as: :remove_shopless_product_tag
  delete 'products', to: 'products#remove', as: :remove_product_tag
  # get 'users/:id', to: 'users#show', as: :user_profile


  devise_for :users, controllers: { registrations: "registrations", omniauth_callbacks: "omniauth_callbacks" }
  as :user do 
    get 'users/:id', to: 'users#show', as: :user_profile    
    patch 'users/:id/switch_to_buyer', to: 'users#switch_to_buyer', as: :switch_to_buyer 
    patch 'users/:id/switch_to_seller', to: 'users#switch_to_seller', as: :switch_to_seller
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'products#index'

  resources :shopless_products do 
    member do 
      get :add
    end
  end

  resources :products do 
    # resources :tags, only: [] do 
      # member do 
      #   delete :remove, as: :remove_tag_of_product
      # end
    # end
  end
   
  resources :searches, only: [:show, :new, :create]
  
  resources :shops do 
    resources :products
  end

  resources :orders

  
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

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
    # match '/users/:id/finish_signup' => 'omniauth_callbacks#finish_signup', via: [:get, :patch], :as => :finish_signup

end
