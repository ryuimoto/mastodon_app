Rails.application.routes.draw do
  resources :topics do
    resources :comments 
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'mastodon_login#index'
  match '/about' => 'mastodon_login#about', :via => :get
  match '/contact' => 'mastodon_login#contact', :via => :get
  match '/link' => 'mastodon_login#link', :via => :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
