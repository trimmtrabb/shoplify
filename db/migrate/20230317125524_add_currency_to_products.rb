class AddCurrencyToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :currency, :integer, default: 0
  end
end
