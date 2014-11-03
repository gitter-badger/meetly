require 'mandrill'
require 'active_support'
require 'day.rb'

class MandrillMailer

  def initialize
    @mailer = Mandrill::API.new 'lv_wbMgDlIX5unkCAMXg4Q'
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
        :from_name=> "Rejestracja Początek 14/15",
        :from_email=>"rejestracja@poczatek.org",
        :subject=>"Potwierdzenie rejestracji uczestnika",
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
    puts "before days!"
    db_days = [Day.new(number: 1), Day.new(number: 2), Day.new(number: 3)]
    options = ""
    puts "start!!"
    if days.length > 0
      if days.length == 3
        options = "Cała konferencja"
        puts options
      elsif days.length == 1
        options = "Dzień"
        options = options + " 1" if days.include?(db_days[0])
        options = options + " 2" if days.include?(db_days[1])
        options = options + " 3" if days.include?(db_days[2])
        puts options
      else
        options = "Dzień"
        options = options + " 1 i" if days.include?(db_days[0])
        options = options + " 2" if days.include?(db_days[1]) && days.include?(db_days[0])
        options = options + " 2 i" if days.include?(db_days[1]) && !days.include?(db_days[0])
        options = options + " 3" if days.include?(db_days[2])
        puts options
      end
    end

    options = options + " + Nocleg x #{participant.nights}" if participant.nights != 0
    options = options + " + Obiad x #{participant.dinners}" if participant.dinners != 0
    puts options
    options
  end


  def get_date
    date = Date.today
    date = date + 7.days
    if date < Date.new(2014, 12, 24)
      return date = date.strftime("%d.%m.%Y")
    else
      return date = Date.new(2014, 12, 24).strftime("%d.%m.%Y")
    end
  end
end