ProjectAlexandria::Application.routes.draw do
  root to: 'welcome#index'

  get 'new_archive', to: 'welcome#new_archive'
  resources :accounts do
    resources :archives do
      resources :archive_items do
        resources :records do
          resources :tweets, path: :tweet
        end
      end
    end
  end

  #get 'auth/twitter'
  #get 'auth/twitter/callback', to: 'sessions#create'
  #get 'auth/twitter', to: 'sessions#failure'
  #get 'welcome/brainwallet'
  #get 'welcome/demos'
end
