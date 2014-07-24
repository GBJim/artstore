class OrderPlacingService
  def initialize(cart,order)
    @order = order
    @cart = cart
  end

  def initialize(order,user,params)
    @order = order
    @user =user
    @params = params
    
  end
 
  def place_order!
    @order.build_item_cache_from_cart(@cart)
    @order.calculate_total!(@cart)
    @cart.clear!
    OrderMailer.notify_order_placed(@order).deliver
  end

  def pay_with_credit_card!
     amount = @order.total * 100 # in cents
   
    Stripe.api_key = Settings.stripe.secret_key
 
    customer = Stripe::Customer.create(
      :email => @user.email,
      :card  => @params[:stripeToken]
      )
 
 
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount,
      :description => @order.token ,
      :currency    => 'usd'
    )
 
    @order.set_payment_with!("credit_card")
    @order.make_payment! 
 
  end

end
