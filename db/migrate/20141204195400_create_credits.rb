class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.belongs_to :user
      t.string :purpose
      t.string :amount
      t.string :time
      t.string :state, default: "new"
      t.belongs_to :credit_kind
    end
  end
end
