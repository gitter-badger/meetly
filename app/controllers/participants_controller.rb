require 'mandrill_mailer'

class ParticipantsController < ApplicationController
  before_filter :set_headers
  before_filter :authenticate_user, :except => [:receive_form, :create_participant]
  protect_from_forgery with: :exception
  respond_to :json, :js

  def create
    parameters = params.require(:participant).permit(:gender, :paid, :name, :surname, :age, :city, :email, :phone)
    
    @participant=Participant.new(parameters)

    role_id = params[:participant][:role_id]
    @participant.role = Role.find(role_id)

    day_ids = params[:participant][:day_ids]
    dinner_ids = params[:participant][:dinner_ids]
    night_ids = params[:participant][:night_ids]

    day_ids.reject! {|d| d.empty?}
    dinner_ids.reject! {|d| d.empty?}
    night_ids.reject! {|d| d.empty?}

    @participant.days = Day.none
    @participant.dinners = Dinner.none
    @participant.nights = Night.none
    
    day_ids.each do |d|
      @participant.days.push(Day.find(d.to_i))
    end
    dinner_ids.each do |d|
      @participant.dinners.push(Dinner.find(d.to_i))
    end
    night_ids.each do |d|
      @participant.nights.push(Night.find(d.to_i))
    end

    @participant.payment_deadline = DateTime.new(params[:participant]["payment_deadline(1i)"].to_i, params[:participant]["payment_deadline(2i)"].to_i, params[:participant]["payment_deadline(3i)"].to_i)
    
    @participant.save!

    redirect_to root_url
  end

  def edit
    @participant = Participant.find(params[:id])
    parameters = params.require(:participant).permit(:paid, :name, :surname, :age, :city, :email, :phone)
    @participant.update(parameters)
    role_id = params[:participant][:role_id]
    @participant.role = Role.find(role_id)

    day_ids = params[:participant][:day_ids]
    dinner_ids = params[:participant][:dinner_ids]
    night_ids = params[:participant][:night_ids]

    day_ids.reject! {|d| d.empty?}
    dinner_ids.reject! {|d| d.empty?}
    night_ids.reject! {|d| d.empty?}

    @participant.days = Day.none
    @participant.dinners = Dinner.none
    @participant.nights = Night.none
    
    day_ids.each do |d|
      @participant.days.push(Day.find(d.to_i))
    end
    dinner_ids.each do |d|
      @participant.dinners.push(Dinner.find(d.to_i))
    end
    night_ids.each do |d|
      @participant.nights.push(Night.find(d.to_i))
    end

    @participant.payment_deadline = DateTime.new(params[:participant]["payment_deadline(1i)"].to_i, params[:participant]["payment_deadline(2i)"].to_i, params[:participant]["payment_deadline(3i)"].to_i)
    
    @participant.save!

    redirect_to root_url
  end

  def edit_form
    @participant = Participant.find(params[:id])
    respond_to do |format|
      format.js {render "edit_form", :locals => {:participant => @participant}}
    end
  end

  def list_mail
    @participant = Participant.find(params[:id])
    respond_to do |format|
      format.js {render "list_mail", :locals => {:participant => @participant}}
    end
  end

  def summary
    @participants = Participant.includes(:days).includes(:role).all
  end

  def index
    @participants = Participant.includes(:days).includes(:role).all
  end

  def destroy
    @participant = Participant.find(params[:id])
    @participant.archived = true
    @participant.save!
    respond_to do |format|
     # format.html {redirect_to participants_url}
     # format.json {head :ok}
      format.js {render "destroy", :locals => {:id => params[:id]}}
    end
  end

  def set_arrived
    @participant = Participant.find(params[:id])
    @participant.arrived =  !@participant.arrived 
    @participant.save!
    respond_to do |format|
      format.js {render "refresh", :locals => {:id => params[:id]}}
    end
  end

  def destroy_and_mail
    @participant = Participant.find(params[:id])
    @participant.archived = true
    @participant.save!
    @participant.send_delete_info
    respond_to do |format|
     # format.html {redirect_to participants_url}
     # format.json {head :ok}
      format.js {render "destroy", :locals => {:id => params[:id]}}
    end
  end


  def wipe
    @participant = Participant.find(params[:id])
    @participant.destroy
    respond_to do |format|
      format.js {render "destroy", :locals => {:id => params[:id]}}
    end
  end

  def unarchive
    @participant = Participant.unscoped.find(params[:id])
    @participant.archived = false
    @participant.save!
    respond_to do |format|
      format.js {render "destroy", :locals => {:id => params[:id]}}
    end
  end

  def show_archived
    @participants = Participant.unscoped.where(archived: true)
  end

  def edit_payment
    @participant = Participant.find(params[:id])    
    @participant.paid = params[:participant][:paid]
    if params[:participant][:role_id]
      @participant.role = Role.find(params[:participant][:role_id])
    end
    @participant.save!
    respond_to do |format|
      format.js
    end
  end

  def payment_confirm
    @participant = Participant.find(params[:id])
    @participant.send_confirm_payment
  end


  def receive_form
    @participant = create_participant
      if @participant.save!
        @participant.send_confirmation
        respond_with @participant.to_json, :status => 201, :callback => params['callback'], content_type: "application/javascript"
      else
        puts @participant.errors.full_messages
        respond_with @participant.errors.to_json, :status => 422, :callback => params['callback'], content_type: "application/javascript"
      end

  end

  def resend_confirmation
    @participant = Participant.find(params[:id])
    @participant.send_confirmation
  end



  protected

  def create_participant

    days = []
    days.push(Day.find_by_number(1)) if params[:day1] == 'true'
    days.push(Day.find_by_number(2)) if params[:day2] == 'true'
    days.push(Day.find_by_number(3)) if params[:day3] == 'true'
    nights = []
    nights.push(Night.find_by_number(1)) if params[:night1] == 'true'
    nights.push(Night.find_by_number(2)) if params[:night2] == 'true'
    dinners = []
    dinners.push(Dinner.find_by_number(1)) if params[:dinner1] == 'true'
    dinners.push(Dinner.find_by_number(2)) if params[:dinner2] == 'true'

    parameters = params.permit(:name, :surname, :age, :city, :email, :phone)
    participant = Participant.new(parameters)

    params[:gender]=='false' ? participant.gender = 'K' : participant.gender = 'M'

    puts "#{participant.name}"
    puts "#{participant.gender} w środku!"

    participant.role = Role.find_by(name: 'UczestnikPo1012')

    participant.days = days

    puts "noc 1 : #{params[:night1]}"
    puts "noc 2 : #{params[:night2]}"


    participant.nights = nights


    puts "obiad 1 : #{params[:dinner1]}"
    puts "obiad 2 : #{params[:dinner2]}"

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
