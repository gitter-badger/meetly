class Participant < ActiveRecord::Base
  belongs_to :role
  belongs_to :event

  has_many :participant_days
  has_many :days, through: :participant_days

  has_many :participant_services
  has_many :services, through: :participant_services

  validates_presence_of :first_name, :last_name, :role, :event_id, :status
#:email
#, :age, :city, :phone, :role, :gender, :event_id, :status
  #validates :age, numericality: { only_integer: true }
  #validates :days, length: { minimum: 1 }
  before_save :calculate_cost
  before_create :calculate_deadline

  enum gender: [:man, :woman]
  enum status: [:created, :pending, :delayed, :paid, :arrived, :deleted]

  scope :active, -> { where.not(status: statuses[:deleted]) }
  scope :created, -> { where(status: statuses[:created]) }
  scope :unpaid, -> { where(status: statuses[:delayed]) }

  scope :women, -> { where(gender: genders[:woman]) }
  scope :men, -> { where(gender: genders[:man]) }

  def full_name
    [last_name, first_name].compact.join(' ')
  end

  def short_info
    if other_info != nil && other_info.length > 10
      other_info[0, 10] + '...'
    else
      other_info
    end
  end

  def registration_date_as_string
    registration_date.strftime('%d-%m-%Y').to_s if registration_date.present?
  end

  def registration_date_as_string=(registration_date_as_string)
    self.registration_date = DateTime.strptime(registration_date_as_string, '%d-%m-%Y') if registration_date.present?
  end

  def payment_deadline_at_string
    payment_deadline.strftime('%d-%m-%Y').to_s if payment_deadline.present?
  end

  def payment_deadline_at_string=(payment_deadline_at_str)
    self.payment_deadline = DateTime.strptime(payment_deadline_at_str, '%d-%m-%Y') if payment_deadline.present?
  end

  def self.gender_attributes_for_select
    genders.keys.to_a.map { |g| [I18n.t("participant_gender.#{g}"), g] }
  end

  def self.status_attributes_for_select
    statuses.keys.to_a.map { |s| [I18n.t("participant_status.#{s}"), s] }
  end

  def status_i18n
    I18n.t("participant_status.#{status}")
  end

  def gender_i18n
    I18n.t("participant_gender.#{gender}")
  end

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
    current_period = PricingPeriod.current_period event_id
    payment_time = 7
    payment_deadline = Time.now.to_date + payment_time.days
    self.payment_deadline = payment_deadline
    logger.debug "Finished deadline calculation. Deadline: #{payment_deadline}"
  end

  def calculate_cost
    logger.debug "Started cost calculation..."
    self.registration_date ||= Time.now.getlocal('+01:00')
    current_period = PricingPeriod.corresponding_period(self.registration_date.to_date, event_id)
    cost = 0
    event = Event.find(event_id)
    services.each do |service|
      logger.info "Adding service #{service.name} cost. For role: #{role_id} and event #{event_id}"
      service_price = service.service_prices.select { |sp| sp.role_id == role_id }
      cost += service_price[0].price
    end
    if days.length == event.days.length
      logger.info "Adding event price for role: #{role_id} and pricing_period: #{current_period.id}"
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
