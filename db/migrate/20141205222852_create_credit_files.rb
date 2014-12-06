class CreateCreditFiles < ActiveRecord::Migration
  def change
    create_table :credit_files do |t|
      t.belongs_to :credit
      t.timestamps
    end
  end
end
