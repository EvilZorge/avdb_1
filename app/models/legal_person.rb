class LegalPerson < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3,  maximum: 40 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
  validates :address, presence: true, length: { minimum: 2,  maximum: 100 }
  validates :registration_code, presence: true, length: { minimum: 2,  maximum: 30 }, :numericality => { :greater_than_or_equal_to => 0 }
  validates :leader, presence: true, length: { minimum: 3,  maximum: 30 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
  validates :accountant_general, presence: true, length: { minimum: 3,  maximum: 30 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
  validates :director, presence: true, length: { minimum: 3,  maximum: 30 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
  validates :sub_company, length: { minimum: 3,  maximum: 40 }, format: { with: /\A[a-zA-Zа-яА-Я\s]+\z/,
    message: "only allows letters" }
  validates :phone, length: { minimum: 3,  maximum: 30 }, format: { with: /\d-+/ }
  validates :email, length: { minimum: 3,  maximum: 30 }, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i }
  validates :skype, length: { minimum: 3,  maximum: 30 }
  validates :creation_date, presence: true, length: { minimum: 3,  maximum: 40 }
end
