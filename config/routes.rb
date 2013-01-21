Selfstarter::Application.routes.draw do
  resources :pledges

  resources :stripes

  root :to => 'rewards#index'
  match '/rewards'               => 'rewards#index'
  get 'rewards/select_reward'
  match 'rewards/checkout'
  match 'rewards/shipping'
  match 'rewards/stripe'
  match 'rewards/pledged'
  match '/rewards/share/:uuid'   => 'rewards#share', :via => :get
  match '/rewards/ipn'           => 'rewards#ipn', :via => :post
  match '/rewards/prefill'       => 'rewards#prefill'
  match '/rewards/postfill'      => 'rewards#postfill'
end
