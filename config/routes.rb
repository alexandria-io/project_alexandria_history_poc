ProjectAlexandria::Application.routes.draw do

  root to: 'welcome#index'

  get 'about', to: 'welcome#about'

  mount Resque::Server, at: '/resque'

  #get 'auth/twitter'
  #get 'auth/twitter/callback', to: 'sessions#create'
  #get 'auth/twitter', to: 'sessions#failure'

  resources :librarians, only: [:show]

  resources :archives, only: [:new, :create, :show] do

    resources :volumes do

      resources :pages

    end

    resources :torrents

  end

  #get 'welcome/brainwallet'
  #get 'welcome/demos'

end
