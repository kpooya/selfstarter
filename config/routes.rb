Selfstarter::Application.routes.draw do
  resources :pledges

  resources :stripes

  root :to => 'reward#index'
  match '/reward'               => 'reward#index'
  get 'reward/select_reward'
  match 'reward/checkout'
  match 'reward/shipping'
  match 'reward/stripe'
  match 'reward/pledged'
  match '/reward/share/:uuid'   => 'reward#share', :via => :get
  match '/reward/ipn'           => 'reward#ipn', :via => :post
  match '/reward/prefill'       => 'reward#prefill'
  match '/reward/postfill'      => 'reward#postfill'
end
