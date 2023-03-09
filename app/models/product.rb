class Product < ApplicationRecord
  validates :name, :price, presence: true

  after_create do
    product = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: product, unit_amount: self.price * 100,
                                 currency: 'usd')
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end
end
