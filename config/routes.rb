Selfstarter::Application.routes.draw do
  #resources :users
  #
  #resources :orders
  #
  #resources :referrals
  #
  #resources :plans
  #
  #resources :addresses
  #
  #resources :pledges

  root :to => 'rewards#index'
  match '/rewards'               => 'rewards#index'
  match 'select' => 'rewards#select'
  match 'earlybird'    => 'rewards#select'
  match 'checkout' => 'rewards#checkout'
  match 'pledge' => 'rewards#pledge'
  match 'share' => 'rewards#share'
  match 'referrals' =>  'rewards#referrals'
  match 'press' =>  'rewards#press'
  match 'distributor'  => 'rewards#distributor'
  match 'rewards/:action'      =>'rewards#rewards'
  match 'rewards/share/:uuid'   => 'rewards#share', :via => :get
  match 'rewards/ipn'           => 'rewards#ipn', :via => :post
end
