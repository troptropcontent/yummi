class AddOrderToChatrooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :chatrooms, :order, null: false, foreign_key: true
    add_reference :chatrooms, :user, null: false, foreign_key: true
    add_reference(:chatrooms, :cook, foreign_key: { to_table: :users })
  end
end
