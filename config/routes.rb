ProjectAlexandria::Application.routes.draw do


  root to: 'welcome#index'
  mount Resque::Server, at: '/resque'

  #get 'auth/twitter'
  #get 'auth/twitter/callback', to: 'sessions#create'
  #get 'auth/twitter', to: 'sessions#failure'

  resources :librarians
  resources :archives do
    resources :volumes do
      resources :pages
    end
    resources :torrents
    resources :archive_items do
      resources :records
    end
  end

  #get 'welcome/brainwallet'
  #get 'welcome/demos'
end
