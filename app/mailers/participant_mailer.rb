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
  	send_message('pocz-tek-registration-confirmation')
  end

  def send_payment_confirmation(participant)
    prepare_payment_confirmation_message(participant)
    send_message('pocz-tek-payment-confirmation')
  end

  def send_cancellation_information(participant)
    prepare_cancellation_information_message(participant)
    send_message('pocz-tek-registration-canceled')
  end

  private

  def prepare_cancellation_information_message(participant)
    ending = gender_ending(participant)
    @message = {
      from_name: "Rejestracja Początek 15/16",
      from_email: "rejestracja@poczatek.org",
      subject: "Twoje zgłoszenie zostało anulowane",
      to: [
        {
          email: "#{participant.email}",
          name: "#{participant.first_name} #{participant.last_name}"
        }
      ],
      global_merge_vars: [{
        name: "KONCOWKA",
        content: "#{ending}"
      }]
    }
  end

  def prepare_confirmation_message(participant)
    ending = gender_ending(participant)
    options = registration_options(participant)

  	@message = {
      from_name: "Rejestracja Początek 15/16",
      from_email: "rejestracja@poczatek.org",
      subject: "Dziękujemy za zgłoszenie na Konferencję Początek 15/16",
      to: [
        {
          email: "#{participant.email}",
          name: "#{participant.first_name} #{participant.last_name}"
        }
      ],
      global_merge_vars: [{
        name: "IMIE",
        content: "#{participant.first_name}"
      },
      {
        name: "NAZWISKO",
        content: "#{participant.last_name}"
      },
      {
        name: "KONCOWKA",
        content: "#{ending}"
      },
      {
        name: "OPCJE",
        content: "#{options}"
      },
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
    ending = gender_ending(participant)
    options = registration_options(participant)
    @message = {
      from_name: "Rejestracja Początek 15/16",
      from_email: "rejestracja@poczatek.org",
      subject: "Dziękujemy za wpłatę",
      to: [
        {
          email: "#{participant.email}",
          name: "#{participant.first_name} #{participant.last_name}"
        }
      ],
      global_merge_vars: [
      {
        name: "KONCOWKA",
        content: "#{ending}"
      },
      {
        name: "OPCJE",
        content: "#{options}"
      },
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

  def registration_options(participant)
    options = ''
    pdays = participant.days
    if pdays.length > 0
      if pdays.length == 3
        options = 'Cała konferencja'
      elsif pdays.length == 1 && pdays.first.number == 3
        options = 'Dzień 3'
      elsif pdays.length == 2
        options = 'Dzień 1 i 2'
      else
        options = 'Nieznana ilość dni - skontaktuj się z rejestracją'
      end
    end

    nightCount = participant.services.select { |s| s.service_group.name == 'Noclegi' }.length
    dinnerCount = participant.services.select { |s| s.service_group.name == 'Obiady' }.length

    options += " + Nocleg x #{nightCount}" if nightCount != 0
    options += " + Obiad x #{dinnerCount}" if dinnerCount != 0

    logger.debug "Determined options: #{options}"
    options
  end

  def send_message(template)
    @mailer.messages.send_template(
      template,
      [],
      message = @message
    )
  end
end
