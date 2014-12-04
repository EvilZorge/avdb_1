class NaturalPerson < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true, length: { minimum: 3,  maximum: 30 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
  validates :surname, presence: true, length: { minimum: 2,  maximum: 30 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
  validates :middlename, presence: true, length: { minimum: 2,  maximum: 30 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
  validates :address, presence: true, length: { minimum: 3,  maximum: 100 }
  validates :passport_data, presence:true, length: { minimum: 3,  maximum: 15 }, uniqueness: true
  validates :phone, length: { minimum: 3,  maximum: 30 }, format: { with: /\d-+/ }
  validates :email, length: { minimum: 3,  maximum: 30 }, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info|ru|by))\z/i }
  validates :skype, length: { minimum: 3,  maximum: 30 }
  validates :work_place, presence: true, length: { minimum: 3,  maximum: 30 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
  validates :function, length: { minimum: 3,  maximum: 30 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
  validates :marital_status, presence: true, length: { minimum: 3,  maximum: 30 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
end
