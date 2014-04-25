ProjectAlexandria::Application.routes.draw do
  root to: 'welcome#index'
  get 'welcome/brainwallet'
  get 'auth/twitter'
  get 'auth/twitter/callback', to: 'sessions#create'
  get 'auth/twitter', to: 'sessions#failure'
  resources :archives do
    resources :records do
      resources :tweets, path: :tweet
    end
  end
end
