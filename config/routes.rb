Rails.application.routes.draw do
    
  mount EpiCas::Engine, at: "/"
  
  devise_for :users
  scope "/admin" do
      resources :users
  end
  
  
  
  resources :quizzes
  
  resources :categories do
      resources :questions do
          resources :answers
          member do
              get :quizzes
          end
      end
  end
  
  resources :links
  
  resources :user_quizzes
  
  resources :languages do
      resources :directions
  end
  
  resources :quiz_pages
    
  get 'welcome/index'
  get 'quizzes/get_selected_question'
  
  get 'questions/update_questions', as: 'update_questions'
  get 'answers/update_answers', as: 'update_answers'
  #get 'questions/update_questions?category_id' => 'questions#update_questions', as: 'update_questions', :format => :json
  get 'questions/show_questions'
  
  #get '/update_questions' => 'quizzes#update_questions', as: :update_questions
  
  #added for the dependent drop downs
  #get 'quizzes/update_questions', as: 'update_questions'
  #get 'quizzes/show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
