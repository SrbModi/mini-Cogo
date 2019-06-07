Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :public do
        post 'login'         => 'sessions#create_session'

        # Location routes
        get 'locations'                   => 'locations#fetch_locations'
        get 'nearby_locations'            => 'locations#fetch_nearby_locations'
      end

      namespace :registered do
        get 'users'                       => 'users#index'
        get 'profile'                     => 'users#fetch_profile'
        get 'user/:id'                    => 'users#fetch_user'
        patch 'user/:id'                  => 'users#update_user'
        patch 'change_password'           => 'users#change_password'
        post 'users'                      => 'users#create_user'
        post 'logout'                     => 'sessions#delete_session'

        # Location routes
        get 'locations'                   => 'locations#fetch_locations'
        get 'nearby_locations'            => 'locations#fetch_nearby_locations'

        # search routes
        get 'search'                      => 'searchs#get_search_results'

        # booking routes
        get 'bookings'                    => 'bookings#get_all'
        get 'booking/:id'                 => 'bookings#fetch_booking'
        get 'my_booking'                  => 'bookings#get_my_booking'
        post 'bookings'                   => 'bookings#create_booking'

      end
    end
  end
end