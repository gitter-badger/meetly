require 'mandrill'
require 'rails'
require 'active_support'

class ParticipantMailer
  def initialize(logger)
    @logger = logger
    logger.debug "Initializing participant mailer with key: #{ENV['MANDRILL_API_KEY']}"
  	@mailer = Mandrill::API.new ENV['MANDRILL_API_KEY']
  end

  attr_accessor :mailer, :logger

  def send_registration_confirmation(participant)
  	prepare_confirmation_message(participant)
  	send_message('registration-confirmation')
  end

  def send_payment_confirmation(participant)
    prepare_payment_confirmation_message(participant)
    send_message('payment-confirmation')
  end

  def send_cancellation_information(participant)
    prepare_cancellation_information_message(participant)
    send_message('registration-canceled')
  end

  private

  def prepare_cancellation_information_message(participant)
    @message = {
      from_name: "jestwiecej.pl",
      from_email: "biuro@jestwiecej.pl",
      subject: "Twoje zgłoszenie zostało anulowane",
      to: [
        {
          email: "#{participant.email}",
          name: "#{participant.first_name} #{participant.last_name}"
        }
      ],
      global_merge_vars: []
    }
  end

  def prepare_confirmation_message(participant)
    title = get_confirmation_title(participant)

  	@message = {
      from_name: "jestwiecej.pl",
      from_email: "biuro@jestwiecej.pl",
      subject: "#{title}",
      to: [
        {
          email: "#{participant.email}",
          name: "#{participant.first_name} #{participant.last_name}"
        }
      ],
      global_merge_vars: [
      {
        name: "DATAP",
        content: "#{participant.payment_deadline.strftime('%d-%m-%Y')}"
      },
      {
        name: "KOSZT",
        content: "#{participant.cost}"
      }]
    }
  end

  def prepare_payment_confirmation_message(participant)
    @message = {
      from_name: "jestwiecej.pl",
      from_email: "biuro@jestwiecej.pl",
      subject: "Dziękujemy za wpłatę",
      to: [
        {
          email: "#{participant.email}",
          name: "#{participant.first_name} #{participant.last_name}"
        }
      ],
      global_merge_vars: [
      {
        name: "KOSZT",
        content: "#{participant.cost}"
      },
      {
        name: "OPLACONO",
        content: "#{participant.paid}"
      },
      {
        name: 'DOZAPLATY',
        content: "#{participant.cost - participant.paid}"
      }
      ]
    }
  end

  def gender_ending(participant)
    if participant.gender == 'man'
      "eś"
    else
      "aś"
    end
  end

  def send_message(template)
    @mailer.messages.send_template(
      template,
      [],
      message = @message
    )
  end

  def get_confirmation_title(participant)
    title = "Dziękujemy za rejestrację na konferencję #{participant.event.name}"
  end
end
