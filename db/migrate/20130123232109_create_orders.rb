class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :uuid
      t.string :stripe_customer_id
      t.string :transaction_id
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.string :user_id
      t.decimal :price
      t.integer :plan_id
      t.integer :tracking_number
      t.integer :phone
      t.date :expiration

      t.timestamps
    end
  end
end
