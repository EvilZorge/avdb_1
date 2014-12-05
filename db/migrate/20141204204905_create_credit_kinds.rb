class CreateCreditKinds < ActiveRecord::Migration
  def change
    create_table :credit_kinds do |t|
      t.string :name
      t.string :max_amount
      t.string :condition
      t.string :rate
      t.string :max_time
      t.string :form_kind
      t.string :term
      t.string :currency
    end
  end
end
