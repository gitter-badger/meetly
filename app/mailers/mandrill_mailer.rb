require 'mandrill'
require 'active_support'
require 'day.rb'

class MandrillMailer

  def initialize
    @mailer = Mandrill::API.new 'lv_wbMgDlIX5unkCAMXg4Q'
  end

  attr_accessor :mailer

  def send_message(template)
    @mailer.messages.send_template(
        template,
        [],
        message = @message 
        )
  end

  def prepare_confirm_payment_message(participant, days)
    ending = get_ending(participant)
    options = get_options(participant, days)
    to_pay_text = get_to_pay_text(participant)
   

    @message = {
        :from_name=> "Rejestracja Początek 14/15",
        :from_email=>"rejestracja@poczatek.org",
        :subject=>"Potwierdzenie wpłaty",
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
                                 :name => "KONCOWKA",
                                 :content => "#{ending}"
                             },
                             {
                                 :name => "OPCJE",
                                 :content => "#{options}"
                             },
                             {
                                 :name => "ZAPLACONO",
                                 :content => "#{participant.paid}"
                             },
                             {
                                 :name => "DOZAPLATY",
                                 :content => "#{to_pay_text}"
                             }]
    }
  end



  def prepare_delete_info_message(participant)
    @message = {
        :from_name=> "Rejestracja Początek 14/15",
        :from_email=>"rejestracja@poczatek.org",
        :subject=>"Usunięcie z listy uczestników",
        :to=>[
            {
                :email=> "#{participant.email}",
                :name=> "#{participant.name} #{participant.surname}"
            },
            ],
        :global_merge_vars=>[{
                                 :name => "IMIE",
                                 :content => "#{participant.name}"
                             }]
    }
  end

  def prepare_confirmation_message(participant, days)

    ending = get_ending(participant)
    options = get_options(participant, days)
    date = get_payment_deadline(participant)

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


private

  def get_ending(participant)
    return "aś" if participant.gender == 'K'
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


  def get_payment_deadline(participant)
    date = participant.payment_deadline
    return date = date.strftime("%d.%m.%Y")
    #if date < Date.new(2014, 12, 24)
      #return date = date.strftime("%d.%m.%Y")
    #else
      #return date = Date.new(2014, 12, 24).strftime("%d.%m.%Y")
    #end
  end

  def get_to_pay_text(participant)
    participation_cost = participant.cost - participant.nights.length * participant.role.price_table.night - participant.dinners.length * participant.role.price_table.dinner
    q = participant.paid - participant.cost
    qm = participant.cost - participant.paid

    q = q.to_s
    qm = qm.to_s


    if participant.paid == participant.cost
        return 'Całkowity koszt Twojego udziału został opłacony. <br />'
    elsif participant.paid > participant.cost
        return 'Otrzymaliśmy o <strong>' + q + ' zł</strong> więcej niż wymagana kwota. <br /> 
        Przy rejestracji w dniu przyjazdu na konferencję pieniądze zostaną Ci zwrócone. <br />'
    elsif participant.paid > participation_cost && participant.paid < participant.cost
        'Do opłacenia pełnego udziału brakuje <strong>' + qm + ' zł.</strong><br />
        Za obiady i noclegi można zapłacić również na miejscu.<br />
        W razie rezygnacji z obiadów lub noclegów, prosimy o kontakt pod adresem rejestracja@poczatek.org. <br />'
    else
        'Do opłacenia podstawowego kosztu udziału brakuje <strong>' + qm + ' zł.</strong><br />
        Prosimy o dopłatę do wymaganej kwoty w ciągu <strong>2 dni roboczych</strong>.'
    end
  end
end