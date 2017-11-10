class PaymentsController < ApplicationController

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # POST /payments
  # POST /payments.json
  def create
    @product = Product.find(params[:product_id])
    @user = current_user
    token = params[:stripeToken]
    # Create the charge on Stripe's servers -- this is the credit card charge
    begin
      charge = Stripe::Charge.create(
        amount: (@product.price*100).to_i, #amount in cents as integer
        currency: "usd",
        source: token,
        description: @product.name,
        receipt_email: @user.email
        )
    if charge.paid
      Order.create(user_id: @user.id, product_id: @product.id, total: @product.price)
    end

    rescue Stripe::CardError => e 
#      # Card declined
      body = e.json_body
      err = body[:error]
      flash[:error] = "Sorry - there was an error processing your payment: #{err[:message]}"
      redirect_to product_path(@product)
    end
  end

end
