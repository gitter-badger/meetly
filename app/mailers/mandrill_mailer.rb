require 'mandrill'
require 'active_support'
require 'day.rb'

class MandrillMailer

  def initialize
    @mailer = Mandrill::API.new 'lv_wbMgDlIX5unkCAMXg4Q'
  end

  attr_accessor :mailer

  def send_confirmation(participant, days)
    prepare_message(participant, days)
    @mailer.messages.send_template(
        'Confirmation_new',
        [{
            :name => 'name',
            :content => ""
        }],
        message = @message
    )
  end

  def prepare_message(participant, days)

    ending = get_ending(participant)
    options = get_options(participant, days)
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

  def get_options(participant, db_days)
    pdays = participant.days
    puts "before days!"
    options = ""
    puts "start!!"
    if pdays.length > 0
      if pdays.length == 3
        options = "Cała konferencja"
        puts options
      elsif pdays.length == 1
        options = "Dzień"
        options = options + " 1" if pdays.include?(db_days[0])
        options = options + " 2" if pdays.include?(db_days[1])
        options = options + " 3" if pdays.include?(db_days[2])
        puts options
      else
        options = "Dzień"
        options = options + " 1 i" if pdays.include?(db_days[0])
        options = options + " 2" if pdays.include?(db_days[1]) && pdays.include?(db_days[0])
        options = options + " 2 i" if pdays.include?(db_days[1]) && !pdays.include?(db_days[0])
        options = options + " 3" if pdays.include?(db_days[2])
        puts options
      end
    end

    options = options + " + Nocleg x #{participant.nights.length}" if participant.nights.length != 0
    options = options + " + Obiad x #{participant.dinners.length}" if participant.dinners.length != 0
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