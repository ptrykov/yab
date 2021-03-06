Rails.application.routes.draw do
  
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, except: [:new, :edit]
      resources :posts, except: [:new, :edit] do
        resources :comments, except: [:new, :edit]
      end

      match '*a', via: [:all], to: 'application#no_route_founded'
    end
  end
end
