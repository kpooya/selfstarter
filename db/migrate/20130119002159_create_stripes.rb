class CreateStripes < ActiveRecord::Migration
  def change
    create_table :stripes do |t|
      t.string :email
      t.string :customer_token

      t.timestamps
    end
  end
end
