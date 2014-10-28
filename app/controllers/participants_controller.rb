require 'mandrill_mailer'

class ParticipantsController < ApplicationController
  before_filter :set_headers
  protect_from_forgery with: :exception

  def index
    @participants = Participant.includes(:days).includes(:role).all
  end

  def receive_form
    @participant = create_participant


    respond_to do |format|
      if @participant.save
        @participant.send_confirmation
        format.json {render :json => @participant.to_json, :callback => params['callback']}
        format.html {render }
      end
    end
  end

  protected

  def create_participant
    parameters = params.permit(:name, :surname, :age, :city, :email, :phone, :nights, :dinners, :gender)
    participant = Participant.new(parameters)
    puts "#{participant.name}"
    participant.role = Role.find_by(name: 'Uczestnik')
    days = []
    days.push(Day.find_by_number(1)) if params[:day1]
    days.push(Day.find_by_number(2)) if params[:day2]
    days.push(Day.find_by_number(3)) if params[:day3]
    participant.days = days
    participant.cost = calculate_price(participant)
    participant
  end


  private

  def calculate_price(participant)
    price_table = participant.role.price_table

    price_table.days if participant.days.length > 2

    sum = 0
    sum = sum + price_table.day1 if participant.days.include?(Day.find_by_number(1))
    sum = sum + price_table.day2 if participant.days.include?(Day.find_by_number(2))
    sum = sum + price_table.day3 if participant.days.include?(Day.find_by_number(3))
    sum
  end



  def set_headers
    headers['Access-Control-Allow-Origin'] = 'blu-soft.pl'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
    headers['Access-Control-Max-Age'] = '86400'
  end


end
