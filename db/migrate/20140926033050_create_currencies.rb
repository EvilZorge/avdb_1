class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :charcode
      t.string :name
      t.integer :rate
      t.integer :rateToday
      t.integer :currency_id
      t.timestamps
    end
  end
end
