class Participant < ActiveRecord::Base
  belongs_to :role
  belongs_to :event

  has_many :participant_days
  has_many :days, through: :participant_days

  has_many :participant_services
  has_many :services, through: :participant_services

  validates_presence_of :first_name, :last_name, :email, :age, :city, :phone, :role, :gender, :event_id, :status
  validates :age, numericality: { only_integer: true }
  validates :days, length: { minimum: 1 }

  before_save :calculate_deadline, :calculate_cost

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
    logger.debug "Started deadline calculation..."
    current_period = PricingPeriod.current_period
    payment_time = 7
    payment_deadline = Time.now.to_date + payment_time.days
    if payment_deadline > current_period.end_date
      payment_deadline = current_period.end_date.to_date
    end
    self.payment_deadline = payment_deadline
    logger.debug "Finished deadline calculation. Deadline: #{payment_deadline}"
  end

  def calculate_cost
    logger.debug "Started cost calculation..."
    current_period = PricingPeriod.current_period
    cost = 0
    services.each do |service|
      logger.debug "Adding service #{service.name} cost. For role: #{role_id}"
      service_price = service.service_prices.select { |sp| sp.role_id == role_id }
      cost += service_price[0].price
    end
    event = Event.find(event_id)
    if days.length == event.days.length
      logger.debug "Adding event price for role: #{role_id} and pricing_period: #{current_period.id}"
      event_price = event.event_prices.select { |ep| ep.role_id == role_id && ep.pricing_period_id == current_period.id }
      cost += event_price[0].price
    else
      days.each do |day|
        logger.debug "Adding day price for role: #{role_id} and pricing_period: #{current_period.id}"
        day_price = day.day_prices.select { |dp| dp.role_id == role_id && dp.pricing_period_id == current_period.id }
        cost += day_price[0].price
      end
    end
    self.cost = cost
    logger.debug "Finished cost calculation. Cost #{cost}"
  end

  def days_include?(day_id)
    days.include?(Day.find_by_number(day_id))
  end
end
