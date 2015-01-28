Rails.application.routes.draw do
  resources :charges
  resources :lessons


 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount StripeEvent::Engine => '/stripe-webhooks'



  devise_for :users, :controllers => { :registrations => 'users/registrations'}
  devise_scope :user do
    # get 'signup/free', to: 'users/registrations#new_free'
    get 'subscribe', to: 'users/registrations#subscribe'
    put 'update_plan', to: 'users/registrations#update_plan'
    put 'update_card', to: 'users/registrations#update_card'
    put 'update_both', to: 'users/registrations#update_both'
    put 'cancel_plan', to: 'users/registrations#cancel_plan'
  end


root 'lessons#index'
  

  get 'pricing' => 'pages#pricing'
  get 'thanks' => 'pages#thanks'
  get 'home' => 'pages#home'




  get 'academic' => 'pages#academic'

  get 'pages/faq' => 'pages#faq'
  get 'pages/terms' => 'pages#terms'
  get 'pages/privacy' => 'pages#privacy'
  get 'film' => 'pages#film'

 


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
