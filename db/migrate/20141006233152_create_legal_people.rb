class CreateLegalPeople < ActiveRecord::Migration
  def change
    create_table :legal_people do |t|
      t.string :name
      t.string :address
      t.string :registration_code
      t.string :leader
      t.string :accountant_general
      t.string :director
      t.string :sub_company
      t.string :income
      t.string :phone
      t.string :email
      t.string :skype
      t.datetime :creation_date
      t.timestamps
    end
  end
end
