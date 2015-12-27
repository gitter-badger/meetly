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
  validates :email, uniqueness: { scope: [:first_name, :last_name, :status] }
  validate :days_must_be_in_proper_groups
  before_save :paid_equals_cost, if: proc { arrived? }
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

  def paid_equals_cost
    paid == cost
  end

  def days_must_be_in_proper_groups
    day1 = Day.find_by_number(1)
    day2 = Day.find_by_number(2)
    day3 = Day.find_by_number(3)

    if days.length == 1 && !days.include?(day3)
      errors.add(:days, 'only third day can be chosen single')
    elsif days.length == 2 && (!days.include?(day1) || !days.include?(day2))
      errors.add(:days, 'only first and second day can be chosen in pair')
    elsif days.length > Day.all.length
      errors.add(:days, 'too many days')
    end
  end

  def calculate_deadline
    logger.debug "Started deadline calculation..."
    current_period = PricingPeriod.current_period
    payment_time = 7
    payment_deadline = Time.now.to_date + payment_time.days
    self.payment_deadline = payment_deadline
    logger.debug "Finished deadline calculation. Deadline: #{payment_deadline}"
  end

  def calculate_cost
    logger.debug "Started cost calculation..."
    self.created_at ||= Time.now.getlocal('+01:00')
    current_period = PricingPeriod.corresponding_period self.created_at.to_date
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
