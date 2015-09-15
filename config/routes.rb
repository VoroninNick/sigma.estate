Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, class_name: "Sigma::User", controllers: {registrations: 'registrations'}


  # devise_for :users, controllers: {
  #  sessions: 'sessions',
  #  registration: 'registration'
  # }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => redirect('apartment')

  get 'apartment' => 'main#apartment'
  match 'apartment/catalog' => 'main#apartment_catalog', via: [:get, :post]
  get 'apartment/catalog/:id' => 'main#apartment_item', as: :apartment_item

  get 'complex' => 'main#complex'
  get 'complex/catalog' => 'main#complex_catalog'
  get 'complex/catalog/:id' => 'main#complex_catalog_item', as: :one_complex
  # get 'complex/catalog/item' => 'main#complex_catalog_item'

  get 'about' => 'main#about'
  get 'calculators' => 'main#calculators'
  get 'contacts' => 'main#contacts'

  get 'comparison' => 'main#comparison'
  post '/mcsubscribe/subscribe' => 'mcsubscribe#subscribe'


  get 'cabinet' => 'cabinet#profile', as: :cabinet_profile
  get 'cabinet/selected-realty' => 'cabinet#selected_realty'
  get 'cabinet/calculators' => 'cabinet#calculators'

  post 'have_questions' => 'main#have_questions_email'
  post 'call_to_order' => 'main#call_to_order_email'
  post 'book_review' => 'main#book_review_email'

  # get  'profile/registration' => 'profile#'
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
