Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :posts, except: [:new, :edit]
    end
  end
end
