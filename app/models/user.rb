class User < ActiveRecord::Base
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerize :role, in: [:user, :security, :analizer, :admin], default: :user       

  has_one :legal_person, dependent: :destroy
  has_one :natural_person, dependent: :destroy
  has_one :credit
end
