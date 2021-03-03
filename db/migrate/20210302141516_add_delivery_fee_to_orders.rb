class AddDeliveryFeeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :delivery_fee_cents, :integer
  end
end
