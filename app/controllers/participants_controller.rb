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

      if @participant.save!
        puts "saved!!"
        @participant.send_confirmation
        respond_with @participant.to_json, :status => 201, :callback => params['callback']
      else
        puts @participant.errors.full_messages
        respond_with @participant.errors.to_json, :status => 422, :callback => params['callback']
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
