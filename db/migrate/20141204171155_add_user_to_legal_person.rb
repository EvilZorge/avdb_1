class AddUserToLegalPerson < ActiveRecord::Migration
  def change
    add_reference :legal_people, :user, index: true
  end
end
