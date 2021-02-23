class CreateMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :meals do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.string :cuisine
      t.integer :price_cents
      t.integer :discount, default: 0
      t.timestamps
    end
  end
end
