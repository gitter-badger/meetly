class Participant < ActiveRecord::Base

  default_scope { where(archived: false)}

	belongs_to :role

	has_many :participant_days
	has_many :days, through: :participant_days

  has_many :participant_nights
  has_many :nights, through: :participant_nights

  has_many :participant_dinners
  has_many :dinners, through: :participant_dinners

  validates_presence_of :name, :surname, :email, :age, :city, :phone, :role, :gender
  validates_numericality_of :age
  #validates :email, :uniqueness => {:scope => [:name, :surname, :archived]}
  validate :days_are_limited, on: [:create, :update]

  before_save :fill_attributes

  scope :night1_sleeper, -> {where(nights: {number: 1}).includes(:nights)}
  scope :night2_sleeper, -> {where(nights: {number: 2}).includes(:nights)}
  scope :dinner1_eater, -> {where(dinners: {number: 1}).includes(:dinners)}
  scope :dinner2_eater, -> {where(dinners: {number: 2}).includes(:dinners)}

  scope :men, -> {where(gender: 'M')}
  scope :women, -> {where(gender: 'K')}


  def send_confirmation
    @mandrill = MandrillMailer.new
    @mandrill.prepare_confirmation_message(self, Day.all)
    @mandrill.send_message('Confirmation_new')
  end

  def send_delete_info
    @mandrill = MandrillMailer.new
    @mandrill.prepare_delete_info_message(self)
    @mandrill.send_message('delete_participant')
  end

  def send_confirm_payment
    @mandrill = MandrillMailer.new
    @mandrill.prepare_confirm_payment_message(self, Day.all)
    @mandrill.send_message('confirm_payment')
  end

  def get_status

    if arrived==true
      return arrived_status
    end 

    if payment_deadline > Time.current.beginning_of_day
      color = 'green'
    else
      if paid > 0
        color = 'orange'
      else
        color = 'red'
      end
    end

    if paid == 0 && cost != 0
      status = 'ZAREJESTROWANY'
    elsif paid == cost
      status = 'OPŁACONY'
      color = 'green'
    elsif paid < cost
      status = 'NIEDOPAŁCONY'
    else
      status = 'NADPŁACONY'
      color = 'blue'
    end

    format_status(color, status)
  end

def format_status(color, status)
  status = '<p style="background-color:' + color + '; color:white; text-align:center">' + status + '</p>'
  status.html_safe
end

def arrived_status
  status = '<p style="background-color: transparent; color: green; text-align: center; font-weight: 900;">PRZYJECHAŁ</p>'
  status.html_safe
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

    #set basic attributes
    self.paid = 0 if paid == nil
    self.cost = calculate_price
    self.role = Role.find_by(name: 'UczestnikPo1012') if self.role==nil

    #set deadline
    self.payment_deadline = Date.today + 7.days if payment_deadline==nil

    #prepare dates 
    eve =  Date.new(2014,12,24)
    today = Date.today


    if self.payment_deadline > eve && today <= eve
      self.payment_deadline = eve
    elsif today > eve && today
      self.payment_deadline = today
    end

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