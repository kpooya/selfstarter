class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :referrer_id
      t.string :referee_id

      t.timestamps
    end
  end
end
