class AddUserToNaturalPerson < ActiveRecord::Migration
  def change
    add_reference :natural_people, :user, index: true
  end
end
