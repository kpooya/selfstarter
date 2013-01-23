class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :name
      t.integer :shipping_address_id
      t.integer :billing_address_id
      t.string  :inviting_code

      t.timestamps
    end

    create_table :referrals do |t|
      t.integer :referrer_id
      t.integer :referee_id

      t.timestamps
    end

    create_table :addresses do |t|
      t.string  :name
      t.integer :user_id
      t.string  :address
      t.string  :address_additional
      t.string  :city
      t.string  :state
      t.string  :country
      t.string  :zip

      t.timestamps
    end

    create_table :plans do |t|
      t.string  :description
      t.integer :price
      t.timestamps
    end

    create_table :orders, :id => false do |t|
      t.string  :stripe_customer_id
      t.string  :transaction_id
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.string  :user_id
      t.decimal :price
      t.integer :plan_id
      t.decimal :shipping
      t.string  :tracking_number
      t.string  :phone
      t.date    :expiration

      t.timestamps
    end
  end
end
