class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.date :delivery_date
      t.string :status
      t.integer :price_cents
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
