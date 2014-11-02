require 'mandrill'
require 'active_support'

class MandrillMailer

  def initialize
    @mailer = Mandrill::API.new
  end

  attr_accessor :mailer

  def send_confirmation(participant)
    prepare_message(participant)
    @mailer.messages.send_template(
        'Confirmation_new',
        [{
            :name => 'name',
            :content => ""
        }],
        message = @message
    )
  end

  def prepare_message(participant)

    ending = get_ending(participant)
    options = get_options(participant)
    date = get_date

    @message = {
        :from_name=> "Początek - rejestracja",
        :from_email=>"bartosz.szczepanski@blu-soft.pl",
        :subject=>"Potwierdzenie rejestracji",
        :to=>[
            {
                :email=> "#{participant.email}",
                :name=> "#{participant.name} #{participant.surname}"
            },
            ],
        :global_merge_vars=>[{
                                 :name => "IMIE",
                                 :content => "#{participant.name}"
                             },
                             {
                                 :name => "NAZWISKO",
                                 :content => "#{participant.surname}"
                             },
                             {
                                 :name => "KONCOWKA",
                                 :content => "#{ending}"
                             },
                             {
                                 :name => "OPCJE",
                                 :content => "#{options}"
                             },
                             {
                                 :name => "KOSZT",
                                 :content => "#{participant.cost}"
                             },
                             {
                                 :name => "DATAP",
                                 :content => "#{date}"
                             }]
    }
  end

  def get_ending(participant)
    return "aś" unless participant.gender
    "eś"
  end

  def get_options(participant)
    days = participant.days
    db_days = Days.all
    options = ""
    if days.length > 0
      if days.length == 3
        options = "Cała konferencja"
      elsif days.length == 1
        options = "Dzień"
        options = options + " 1" if days.include?(db_days.find_by(number: 1))
        options = options + " 2" if days.include?(db_days.find_by(number: 2))
        options = options + " 3" if days.include?(db_days.find_by(number: 3))
      else
        options = "Dzień"
        options = options + " 1 i" if days.include?(db_days.find_by(number: 1))
        options = options + " 2" if days.include?(db_days.find_by(number: 2)) && days.include?(db_days.find_by(number: 1))
        options = options + " 2 i" if days.include?(db_days.find_by(number: 2)) && !days.include?(db_days.find_by(number: 1))
        options = options + " 3" if days.include?(db_days.find_by(number: 3))
      end
    end

    options = options + " Nocleg x #{participant.nights}"
    options = options + " Obiad x #{participant.dinners}"
    options
  end


  def get_date
    date = Date.now
    date = date + 7.days
    if date < Date.new(2014, 24, 12)
      return date = date.strftime("%d.%m.%Y")
    else
      return date = Date.new(2014, 24, 12).strftime("%d.%m.%Y")
    end
  end
end