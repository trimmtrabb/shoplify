class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [
        price_data: {
          product: product.stripe_product_id,
          unit_amount: product.price * 100,
          currency: 'usd'
        },
        quantity: 1,
      ],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url
    })
    respond_to do |format|
      format.js
    end
  end
end
