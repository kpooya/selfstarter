class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :description
      t.decimal :price
      t.integer :number

      t.timestamps
    end
  end
end
