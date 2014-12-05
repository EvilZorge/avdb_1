class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.belongs_to :credit
      t.string :money

    end
  end
end
