ProjectAlexandria::Application.routes.draw do
  root to: 'welcome#index'
  mount Resque::Server, at: '/resque'

  #get 'auth/twitter'
  #get 'auth/twitter/callback', to: 'sessions#create'
  #get 'auth/twitter', to: 'sessions#failure'

  resources :archives do
    resources :archive_items do
      resources :records do
        resources :tweets, path: :tweet
      end
    end
  end

  #get 'welcome/brainwallet'
  #get 'welcome/demos'
end
