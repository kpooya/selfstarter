class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.string :email
      t.string :stripe_customer_token

      t.timestamps
    end
  end
end
