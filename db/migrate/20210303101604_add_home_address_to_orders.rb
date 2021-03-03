class AddHomeAddressToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :home_address, :string
  end
end
