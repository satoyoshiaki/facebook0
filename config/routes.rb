Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :favorites, only: [:create, :destroy]
  resources :blogs do
    collection do
      post :confirm
      get :favorites_index
    end
  end
  root to: 'sessions#new'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end