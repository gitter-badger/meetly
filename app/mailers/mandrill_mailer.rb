require 'mandrill'

class MandrillMailer

  def initialize
    @mailer = Mandrill::API.new
  end

  attr_accessor :mailer

  def send_confirmation(participant)
    prepare_message(participant)
    @mailer.messages.send_template(
        'confirmation2',
        [{
            :name => 'main',
            :content => "empty"
        }],
        message = @message
    )
  end

  def prepare_message(participant)
    @message = {
        :from_name=> "Początek",
        :from_email=>"info@poczatek.org",
        :subject=>"Potwierdzenie rejestracji",
        :to=>[
            {
                :email=> "#{participant.email}",
                :name=> "#{participant.name}"
            },
            :global_merge_vars=>[{
                :name => "PNAME",
                :content => "#{participant.name}"
                                 }]
        ]
    }
  end

end