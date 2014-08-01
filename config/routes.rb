Rails.application.routes.draw do

#api routes
  namespace :api, defaults: {format: 'json'} do
    devise_scope :user do
      post 'change_pass', to: 'registrations#change_password', as: 'change_pass'
      post 'edit_profile', to: 'registrations#edit_profile', as: 'edit_profile'
      post 'log_out', to: 'sessions#sign_out', as: 'log_out'
      get 'profile', to: 'registrations#profile', as: 'profile'
      devise_for :users
      post 'log_in', to: 'sessions#sign_in'

    end
    get 'condos_list', to: 'condos#list', as: 'listcondo'
    get 'condos_detail', to: 'condos#show', as: 'showcondo'
    post 'send_feedback', to: 'feedbacks#create'


  end


#resources :event_images
  resources :condos
  post 'condos/images', to: 'condos#create_image', as: 'create_image'
  resources :feedbacks, :only => [:index, :destroy]
  get 'feedbacks/moves', to: "feedbacks#move_archive", as: 'archive'
  get 'feedbacks/destroymultiple', to: "feedbacks#destroy_multiple", as: 'destroy_feedbacks'
  get 'feedbacks/confirms/:id', to: "feedbacks#confirm_delete", as: 'confirm_feedback'
  get 'feedbacks/reply/:id', to: "feedbacks#create_reply", as: 'create_reply'
  post 'feedbacks/reply', to: "feedbacks#reply", as: 'reply'
  put 'feedbacks/reply', to: "feedbacks#update_reply", as: 'update_reply'
  post 'feedbacks/destroy_multiple', to: "feedbacks#destroy_multiple"
  post 'feedbacks/move_multiple', to: "feedbacks#move_multiple"
  get 'feedbacks/archive', to: "feedbacks#index_archive", as: "feedbacks_archive"
  resources :events
  resources :facilities do
    get 'timeslot'
    member do
      get 'confirm'
    end

  end
  post 'facilities/change_active', to: 'facilities#change_active'
  post 'facilities/change_peak', to: 'facilities#change_peak'
  post 'facilities/add_timeslot', to: 'facilities#add_timeslot', as: 'add_timeslot'


  resources :facility_statuses, only: [:new, :create]

  resource :facility_status, only: [] do
    member do
      get 'previous'
      get 'next'
    end
  end

  get 'bookings/filter/:id' => 'bookings#filter', as: 'filter'
  resources :bookings, only: [:index, :update, :destroy] do

    collection do
      post 'deleteColection'
      post 'updateStatus'
      get 'confirm'
    end
  end

  resources :bulletins do
    member do
      get 'confirm'
    end
  end

  resources :forms do
    collection do
      post 'filter'
    end
    member do
      get 'confirm'
    end
  end

  resources :guard_houses, only: [:index, :update] do
    collection do
      post 'update_photo'
      post 'delete_photo'
    end
  end

  resource :guard_house, only: [:edit] do

  end

  resources :house_rules do
    member do
      get 'confirm'
    end
  end

  resources :privileges, only: []

  resources :privilege_users, only: []

  resources :services, only: []

  resources :service_categories, only: []

  devise_scope :user do
    get 'user/profile/:id', to: 'registrations#profile', as: 'profile'
    patch 'user/change_pass', to: 'registrations#change_password', as: 'change_pass'
    patch 'user/add_avatar', to: 'registrations#add_avatar', as: 'add_avatar'
  end
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

# You can have the root of your site routed with "root"
  authenticated :user do
    root :to => 'homes#index', :as => :authenticated_root
  end
  root :to => redirect('/users/sign_in')

# Example of regular route:
#   get 'products/:id' => 'catalog#view'

# Example of named route that can be invoked with purchase_url(id: product.id)
#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

# Example resource route (maps HTTP verbs to controller actions automatically):
  resources :homes, only: [:index]

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

  namespace :api, path: nil do
    resource :event, only: [], path: 'api' do
      collection do
        get 'events' => 'events#index'
      end
      member do
        get 'event_detail' => 'events#show'
        get 'event_detail_photo' => 'events#event_photo'
        post 'join_event' => 'events#join_event'
      end
    end
  end

  namespace :api, path: nil, defaults: {format: :json} do
    resource :bulletin, only: [], path: 'api' do
      collection do
        get 'bulletins' => 'bulletins#index'
      end
      member do
        get 'bulletin_detail' => 'bulletins#show'
      end
    end

    resource :form, only: [], path: 'api' do
      collection do
        get 'forms' => 'forms#index'
      end
    end

    resource :house_rule, only: [], path: 'api' do
      collection do
        get 'house_rules' => 'house_rules#index'
      end
    end

    resource :privileges, only: [], path: 'api' do
      collection do
        get 'privileges' => 'privileges#index'
        get 'privilege_detail' => 'privileges#privilege_detail'
        post 'redeem_previlege' => 'privileges#redeem_previlege'
      end
      member do
      end
    end

    resource :privilege_user, only: [], path: 'api' do
      collection do
      end
      member do
      end
    end

    resource :service_category, only: [], path: 'api' do
      collection do
        get 'service_categories' => 'service_categories#index'
      end
    end

    resource :service, only: [], path: 'api' do
      collection do
        get 'services' => 'services#index'
      end
      member do
        get 'service_detail' => 'services#show'
      end
    end

    resource :chats, only: [], path: 'api' do
      collection do
        post 'request_friend' => 'chats#request_friend'
        post 'confirm_friend_request' => 'chats#confirm_friend_request'
        get 'friend_list' => 'chats#friend_list'
        get 'pending_request' => 'chats#pending_request'
        get 'neightbours' => 'chats#neightbours'
        post 'send_chat_message' => 'chats#send_chat_message'
        post 'create_group_chat' => 'chats#create_group_chat'
        post 'send_chat_group' => 'chats#send_chat_group'
      end
    end

  end

  namespace :api, path: nil do
    resources :booking, only: [], path: 'api' do
      collection do
        get 'booking_facilities' => 'bookings#index'
        post 'make_a_booking' => 'bookings#make_a_booking'
        get 'check_booking' => 'bookings#check_booking'
      end
    end
  end
end

