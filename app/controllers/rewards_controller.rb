class RewardsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :ipn

  def index
    referring_code = params[:r]
    if referring_code
      session[:referring_code] = referring_code
    end
  end

  def checkout
  end

  def select_reward
    #Order.all.inject({}) { |counts, order| if }
    #
    #  for order in Order.all
    #
    #  end
    #@counts = {}

    #Order.all.each do |order| begin
    #   #@counts[Order.plan_id]
    #end

    @counts = {}
    @counts[1] = 0;
    @counts[2] = 0;
    @counts[3] = 0;
    @counts[4] = 0;
    @counts[5] = 0;


    for order in Order.all
      @counts[order.plan_id] += 1
    end
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

  def prefill
    @user = User.find_or_create_by_email!(params[:email])
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

  def pledge
    #@order = Order.find_by_uuid(params[:uuid])
    logger.info("session: " + session.inspect)

    # TODO, high priority, if user has come here before, what to do?
    user = User.new()
    user.update_attributes(params[:user])
    user.save!

    shipping_address = Address.new(params[:shipping])
    shipping_address.save!
    if (params[:same_as_my_shipping_address]=="1")
      billing_address = Address.new(params[:billing])
      billing_address.save!
    else
      billing_address = shipping_address
    end

    order = Order.new(params[:order])


    plan_id = (session[:reward_tier] && session[:reward_tier].to_i) || 1;

    plan = Plan.find(plan_id)
    order.update_attributes(:plan_id => plan_id,
                            :price => plan.price,
                            :shipping_address_id => shipping_address.id,
                            :billing_address_id => billing_address.id,
                            :user_id => user.id)

    token = params[:user_stripe_token]

    stripe_customer = Stripe::Customer.create(
        :card => token,
        :description => user.email
    )

    order.save!

    if session[:referring_code]
      referrer = User.find_by_referring_code(session[:referring_code])
      if referrer
        Referral.create(:referrer_id => referrer.id, :referee_id => user.id, :order_id => order.id)
      end
    end

    logger.info("Stripe_customer: " + stripe_customer.inspect);
    logger.info("Order: " + order.inspect);

    amount_in_cents = (order.price * 100).to_i

# save the customer ID in your database so you can use it later
    order.update_attributes(:stripe_customer_id => stripe_customer.id)

# later
    stripe_customer_id = order.stripe_customer_id

    if Rails.env.development?
# charge the Customer instead of the card
      Stripe::Charge.create(
          :amount => amount_in_cents, # $15.00 this time
          :currency => "usd",
          :customer => stripe_customer_id
      )
    end

    session.clear
    session[:user] = user.id
    redirect_to SubPath.getUrl("/rewards/share")
  end

  def share
    logger.info("session: " + session.inspect)
    user = User.find_by_id(session[:user])
    if user
      @referring_url = user.get_referring_url
      @referring_url_encoded = URI.escape(@referring_url)
    else
      @referring_url = LINQUET_MINI_URL
      @referring_url_encoded = URI.escape(LINQUET_MINI_URL)
    end

    @tweet_query_string = "original_referer=" + @referring_url_encoded + "&text=" + URI.escape("Awesome! Never Lose Anything Again With Linquet Mini ") + @referring_url_encoded + " #iwantthis #ReTweet";
  end

  def referrals
    render :layout => nil
  end

  def ipn
  end
end
