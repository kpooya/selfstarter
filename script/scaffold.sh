force='--force'

rails g scaffold address name:string user_id:integer address:string address_additional:string city:string state:string country:string zip:string $force
 
rails g scaffold plan description:string price:decimal number:integer $force
 
rails g scaffold referral referrer_id:string referee_id:string order_id:integer $force

rails g scaffold order uuid:string stripe_customer_id:string transaction_id:string billing_address_id:integer shipping_address_id:integer user_id:string price:decimal plan_id:integer tracking_number:integer phone:integer expiration:date $force

rails g scaffold user email:string name:string referring_code:string $force
 
 