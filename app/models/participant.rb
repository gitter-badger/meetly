class Participant < ActiveRecord::Base
	belongs_to :role
	has_many :participant_days
	has_many :days, through: :participant_days

  has_many :participant_nights
  has_many :nights, through: :participant_nights

  has_many :participant_dinners
  has_many :dinners, through: :participant_dinners

  validates_presence_of :name, :surname, :email, :age, :city, :phone, :role, :gender
  validates_numericality_of :age

  validates :email, :uniqueness => {:scope => [:name, :surname]}

  validate :days_are_limited, on: [:create, :update]

  before_save :fill_attributes

  def send_confirmation
    @mandrill = MandrillMailer.new
    @mandrill.send_confirmation(self, Day.all)
  end

  attr_accessor :mandrill


  private

  def days_are_limited
    if self.days.length > 3
      errors.add(:days, "there's no more days than 3")
      false
    elsif self.days.length < 1
      errors.add(:days, "participant should attend at least one days")
      false
    end
  end

  def fill_attributes
    self.paid = 0
    self.cost = calculate_price
    self.role = Role.find_by(name: 'Uczestnik') if self.role==nil
  end

  def calculate_price
    price_table = self.role.price_table

    if self.days.length > 2
      sum = price_table.days
    else
      sum = 0
      sum = sum + price_table.day1 if self.days.include?(Day.find_by_number(1))
      sum = sum + price_table.day2 if self.days.include?(Day.find_by_number(2))
      sum = sum + price_table.day3 if self.days.include?(Day.find_by_number(3))
    end



    sum = sum + self.nights.length * price_table.night
    sum = sum + self.dinners.length * price_table.dinner
    sum
  end
end