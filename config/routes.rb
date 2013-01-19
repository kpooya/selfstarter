Selfstarter::Application.routes.draw do
  resources :pledges

  resources :stripes

  root :to => 'preorder#index'
  match '/preorder'               => 'preorder#index'
  get 'preorder/select_perk'
  match 'preorder/checkout'
  match 'preorder/shipping'
  match 'preorder/stripe'
  match 'preorder/pledged'
  match '/preorder/share/:uuid'   => 'preorder#share', :via => :get
  match '/preorder/ipn'           => 'preorder#ipn', :via => :post
  match '/preorder/prefill'       => 'preorder#prefill'
  match '/preorder/postfill'      => 'preorder#postfill'
end
