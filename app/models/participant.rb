class Participant < ActiveRecord::Base
  default_scope { where(archived: false) }

  belongs_to :role
  belongs_to :event

  has_many :participant_days
  has_many :days, through: :participant_days

  has_many :participant_services
  has_many :services, through: :participant_services

  validates_presence_of :first_name, :last_name, :email, :age, :city, :phone, :role, :gender, :event_id, :status
  validates :age, numericality: { only_integer: true }
  validates :days, length: { minimum: 1 }

  before_save :calculate_deadline, :calculate_price

  scope :dayer1, -> { where(days: { number: 1 }).includes(:days) }
  scope :dayer2, -> { where(days: { number: 2 }).includes(:days) }
  scope :dayer3, -> { where(days: { number: 3 }).includes(:days) }

  enum gender: [:man, :woman]
  enum status: [:created, :pending, :delayed, :paid, :arrived]

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

  attr_accessor :mandrill

  # private

  def calculate_deadline
    # TODO: calculate deadline
  end

  def calculate_price
    # TODO: calculate the price
  end

  def days_include?(day_id)
    days.include?(Day.find_by_number(day_id))
  end
end
