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
    template_name = registration_confirmation_template_name participant
  	prepare_confirmation_message(participant)
  	send_message(template_name)
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
    title = cancelation_information_title participant

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
      global_merge_vars: []
    }
  end

  def prepare_confirmation_message(participant)
    title = registration_confirmation_title(participant)

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
    title = payment_confirmation_title participant

    @message = {
      from_name: "jestwiecej.pl",
      from_email: "biuro@jestwiecej.pl",
      subject: title,
      to: [
        {
          email: "#{participant.email}",
          name: "#{participant.first_name} #{participant.last_name}"
        }
      ],
      global_merge_vars: []
    }
  end

  def send_message(template)
    @mailer.messages.send_template(
      template,
      [],
      message = @message
    )
  end

  def registration_confirmation_title(participant)
    "Dziękujemy za rejestrację na konferencję #{participant.event.name}"
  end

  def payment_confirmation_title(participant)
    "Dziękujemy za wpłatę na konferencję #{participant.event.name}"
  end

  def cancelation_information_title(participant)
    "Twoje zgłoszenie na konferencję #{participant.event.name} zostało anulowane"
  end

  def registration_confirmation_template_name(participant)
    event_name = participant.event.name
    if(event_name == 'Randy Clark 2-4.06')
      'registration-confirmation-randy'
    elsif(event_name == 'Blaine Cook 25-27.04')
      'registration-confirmation-blaine'
    else
      'registration-confirmation-gary'
    end
  end
end
