class CreateNaturalPeople < ActiveRecord::Migration
  def change
    create_table :natural_people do |t|
      t.string :name
      t.string :surname
      t.string :middlename
      t.string :address
      t.string :passport_data
      t.string :phone
      t.string :email
      t.string :skype
      t.string :work_place
      t.string :function
      t.string :income
      t.integer :age
      t.string :marital_status
      t.timestamps
    end
  end
end
