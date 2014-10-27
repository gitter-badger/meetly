require 'mandrill'

class MandrillMailer

  def initialize
    @mailer = Mandrill::API.new ENV["MAILCHIMP_API_KEY"]
  end

  attr_accessor :mailer

  def send_confirmation(participant)
    @mailer.send(
        template_name: "Początek 14/15 - Potwierdzenie Rejestracji",
        template_content: nil,
        message: {
          subject: "Dziekujemy za rejestracje!",
          from_email: "szczepan97@gmail.com",
          from_name: "Bartosz Szczepanski",
          to: {
              email: participant.email,
              name: participant.name + " " + participant.surname
          },
          important: true
        },
        async: true
    )
  end

end