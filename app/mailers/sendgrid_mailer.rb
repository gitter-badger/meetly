require 'sendgrid-ruby'

class SendgridMailer

  def initialize
    @client = SendGrid::Client.new(api_key: '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')
  end

  def send_payment_confirmation(participant)
    prepare_payment_confirmation_message participant
    res = @client.send(@mail)
  end

private

  def prepare_payment_confirmation_message(participant)
    title = payment_confirmation_title participant
    template = SendGrid::Template.new('a98cf19a-9f9d-45a3-8225-360842aede4a')

    @mail = SendGrid::Mail.new do |m|
      m.to = "#{participant.email}"
      m.from = "hello@barnski.pl"
      m.subject = title
      m.template = template
      m.text = "body"
    end
  end

  def payment_confirmation_title(participant)
    "Dziękujemy za wpłatę na konferencję #{participant.event.name}"
  end

end
