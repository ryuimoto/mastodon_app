Rails.application.routes.draw do
  root 'mastodon_login#index'
  get 'mastodon_login/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
