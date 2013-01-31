Selfstarter::Application.routes.draw do
    resources :users

  resources :orders

  resources :referrals

  resources :plans

  resources :addresses

  resources :pledges

  root :to => 'rewards#index'
  match '/rewards'               => 'rewards#index'
  get 'rewards/select_reward'
  match 'rewards/checkout'
  match 'rewards/shipping'
  match 'rewards/stripe'
  match 'rewards/pledge'
  match 'rewards/share'
  match 'rewards/earlybird'    => 'rewards#select_reward'
  match 'rewards/referrals'
  match '/rewards/share/:uuid'   => 'rewards#share', :via => :get
  match '/rewards/ipn'           => 'rewards#ipn', :via => :post
  match '/rewards/prefill'       => 'rewards#prefill'
  match '/rewards/postfill'      => 'rewards#postfill'
end
