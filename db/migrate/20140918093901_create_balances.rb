class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.integer :price
      t.string :state
      t.timestamps
    end
  end
end
