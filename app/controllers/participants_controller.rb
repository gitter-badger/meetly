require 'mandrill_mailer'

class ParticipantsController < ApplicationController
  before_filter :set_headers
  protect_from_forgery with: :exception
  respond_to :json, :js

  def index
    @participants = Participant.includes(:days).includes(:role).all
  end

  def receive_form
    @participant = create_participant
    puts "created!!!"
    puts "#{@participant.gender}"
    puts "#{@participant.valid?} ::: VALID?"
      if @participant.save!
        puts "saved!!"
        @participant.send_confirmation
        respond_with @participant.to_json, :status => 201, :callback => params['callback'], content_type: "application/javascript"
      else
        puts @participant.errors.full_messages
        respond_with @participant.errors.to_json, :status => 422, :callback => params['callback'], content_type: "application/javascript"
      end

  end

  protected

  def create_participant
    parameters = params.permit(:name, :surname, :age, :city, :email, :phone)
    participant = Participant.new(parameters)

    !params[:gender] ? participant.gender = 'M' : participant.gender = 'K'

    puts "#{participant.name}"
    puts "#{participant.gender} w środku!"


    participant.role = Role.find_by(name: 'Uczestnik')

    days = [] 
    days.push(Day.find_by_number(1)) if params[:day1]==true
    days.push(Day.find_by_number(2)) if params[:day2]==true
    days.push(Day.find_by_number(3)) if params[:day3]==true
    participant.days = days

    puts "noc 1 : #{params[:night1]}"
    puts "noc 2 : #{params[:night2]}"

    nights = []
    nights.push(Night.find_by_number(1)) if params[:night1]==true
    nights.push(Night.find_by_number(2)) if params[:night2]==true
    participant.nights = nights


    puts "obiad 1 : #{params[:dinner1]}"
    puts "obiad 2 : #{params[:dinner2]}"

    dinners = []
    dinners.push(Dinner.find_by_number(1)) if params[:dinner1]==true
    dinners.push(Dinner.find_by_number(2)) if params[:dinner2]==true
    participant.dinners = dinners


    puts "DNIII : #{participant.days.length}"
    puts "NOCE : #{participant.nights.length}"
    puts "obiady : #{participant.dinners.length}"

    participant
  end







  private

    def set_headers
    headers['Access-Control-Allow-Origin'] = 'blu-soft.pl'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
    headers['Access-Control-Max-Age'] = '86400'
  end


end
