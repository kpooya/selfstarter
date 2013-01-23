class RewardsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :ipn

  def index
  end

  def checkout
  end

  def select_reward
  end

  def shipping
    session[:reward_tier] = params[:reward_tier]
    logger.info(session[:reward_tier])
  end

 def stripe
    session[:shipping] = params[:shipping]
    logger.info(session.inspect)

    @order = Order.new()
  end

 def pledged
   logger.info("session: " + session.inspect)
    user = User.new()
    user.update_attributes(session[:pledge])
    token = params[:user_stripe_token]

    stripe_customer = Stripe::Customer.create(
        :card => token,
        :description => user.email
    )

# charge the Customer instead of the card
   Stripe::Charge.create(
       :amount => 1000, # in cents
       :currency => "usd",
       :customer => stripe_customer.id
   )

   logger.info("Stripe_customer_id: " + stripe_customer.id);

# save the customer ID in your database so you can use it later
   user.update_attributes(:stripe_customer_id => stripe_customer.id)

# later
   stripe_customer_id = user.stripe_customer_id

   Stripe::Charge.create(
       :amount => 1500, # $15.00 this time
       :currency => "usd",
       :customer => stripe_customer_id
   )


   session.clear
 end

  def prefill
    @user  = User.find_or_create_by_email!(params[:email])
    @order = Order.prefill!(:name => Settings.product_name, :price => Settings.price, :user_id => @user.id)

    # This is where all the magic happens. We create a multi-use token with Amazon, letting us charge the user's Amazon account
    # Then, if they confirm the payment, Amazon POSTs us their shipping details and phone number
    # From there, we save it, and voila, we got ourselves a preorder!
    @pipeline = AmazonFlexPay.multi_use_pipeline(@order.uuid, :transaction_amount => Settings.price, :global_amount_limit => Settings.charge_limit, :collect_shipping_address => "True", :payment_reason => Settings.payment_description)
    redirect_to @pipeline.url("#{request.scheme}://#{request.host}/rewards/postfill")
  end

  def postfill
    unless params[:callerReference].blank?
      @order = Order.postfill!(params)
    end
    # "A" means the user cancelled the preorder before clicking "Confirm" on Amazon Payments.
    if params['status'] != 'A' && @order.present?
      redirect_to :action => :share, :uuid => @order.uuid
    else
      redirect_to root_url
    end
  end

  def share
    #@order = Order.find_by_uuid(params[:uuid])
    logger.info("session: " + session.inspect)
    user = User.new()
    user.update_attributes(session[:pledge])
    token = params[:user_stripe_token]

    stripe_customer = Stripe::Customer.create(
        :card => token,
        :description => user.email
    )

# charge the Customer instead of the card
    Stripe::Charge.create(
        :amount => 1000, # in cents
        :currency => "usd",
        :customer => stripe_customer.id
    )

    logger.info("Stripe_customer_id: " + stripe_customer.id);

# save the customer ID in your database so you can use it later
    order = Order.new
    order.update_attributes(:stripe_customer_id => stripe_customer.id)

# later
    stripe_customer_id = order.stripe_customer_id

    Stripe::Charge.create(
        :amount => 1500, # $15.00 this time
        :currency => "usd",
        :customer => stripe_customer_id
    )


    session.clear
  end

  def ipn
  end
end
