require 'mandrill'
require 'active_support'

class ParticipantMailer
  def initialize
  	@mailer = Mandrill::API.new ENV['MANDRILL_API_KEY']
  end

  attr_accessor :mailer

  def send_confirmation(participant)
  	prepare_confirmation_message(participant)
  	send_message('confirmation')
  end

  private

  def prepare_confirmation_message(participant)
  	@message = {
      from_name: "Rejestracja Początek 14/15",
      from_email: "rejestracja@poczatek.org",
      subject: "Potwierdzenie wpłaty",
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
        name: "ZAPLACONO",
        content: "#{participant.paid}"
      }]
    }
  end

  def send_message(template)
    @mailer.messages.send_template(
      template,
      [],
      message = @message
    )
  end
end
