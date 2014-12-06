class Credit < ActiveRecord::Base
  belongs_to :credit_kind
  belongs_to :user
  validates :purpose, presence: true, length: { minimum: 3,  maximum: 30 }
  validates :time, presence: true, length: { minimum: 2,  maximum: 10 }
  validates :amount, presence: true, length: { minimum: 1,  maximum: 10 }

  has_one :contract
  has_many :credit_files, dependent: :destroy
  accepts_nested_attributes_for :credit_files,:reject_if => lambda { |p| p['document'].blank? },
    allow_destroy: true
  state_machine :state, initial: :new do

    event :secure do
      transition :new => :secured
    end

    event :analize do
      transition :secured => :analized
    end

    event :reject do
      transition [:new,:secured,:analized] => :sketch
    end

    event :approve do
      transition :analized => :approved
    end

  end
end
