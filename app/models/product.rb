class Product < ApplicationRecord
  enum currency: %w( usd eur gbp )

  validates :name, :price, presence: true

  after_create do
    product = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: product, unit_amount: self.price * 100,
                                 currency: currency)
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end

  after_update :assign_new_stripe_price, if: :saved_change_to_price?
  def assign_new_stripe_price
    price = Stripe::Price.create(product: stripe_product_id, unit_amount: self.price * 100,
                                 currency: currency)
    update(stripe_price_id: price.id)
  end

  def to_builder
    Jbuilder.new do |product|
      product.price stripe_price_id
      product.quantity 1
    end
  end
end
