require 'mandrill_mailer'

class ParticipantsController < ApplicationController
  before_action :set_headers
  before_action :authorize_user, except: [:receive_form, :create_participant]
  protect_from_forgery with: :exception
  respond_to :json, :js

  def index
    @participants = event.participants.order(:id)
    @days = event.days.sort
    @services = event.services.sort
  end

  def create
    parameters = params.require(:participant).permit(:arrived, :gender, :paid, :first_name, :last_name, :age, :city, :email, :phone)

    @participant = Participant.new(parameters)

    role_id = params[:participant][:role_id]
    @participant.role = Role.find(role_id)

    day_ids = params[:participant][:day_ids]
    dinner_ids = params[:participant][:dinner_ids]
    night_ids = params[:participant][:night_ids]

    day_ids.reject!(&:empty?)
    dinner_ids.reject!(&:empty?)
    night_ids.reject!(&:empty?)

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
    parameters = params.require(:participant).permit(:arrived, :paid, :first_name, :last_name, :age, :city, :email, :phone)
    @participant.update(parameters)
    role_id = params[:participant][:role_id]
    @participant.role = Role.find(role_id)

    day_ids = params[:participant][:day_ids]
    dinner_ids = params[:participant][:dinner_ids]
    night_ids = params[:participant][:night_ids]

    day_ids.reject!(&:empty?)
    dinner_ids.reject!(&:empty?)
    night_ids.reject!(&:empty?)

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
      format.js { render "edit_form", locals: { participant: @participant } }
    end
  end

  def list_mail
    @participant = Participant.find(params[:id])
    respond_to do |format|
      format.js { render "list_mail", locals: { participant: @participant } }
    end
  end

  def summary
    @participants = Participant.includes(:days).includes(:role).all
    @vol = Participant.all.where(role_id: 31).inject(0) do |sum, e|
      if (e.cost - e.paid) < 0
        sum -= (e.cost - e.paid)
      else
        sum
      end
    end

    @par = Participant.all.where.not(role_id: 31).inject(0) do |sum, e|
      if (e.cost - e.paid) < 0
        sum -= (e.cost - e.paid)
      else
        sum
      end
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    @participant.archived = true
    @participant.save!
    respond_to do |format|
      # format.html {redirect_to participants_url}
      # format.json {head :ok}
      format.js { render "destroy", locals: { id: params[:id] } }
    end
  end

  def set_arrived
    @participant = Participant.find(params[:id])
    @participant.arrived = !@participant.arrived
    @participant.save!
    respond_to do |format|
      format.js { render "refresh", locals: { id: params[:id] } }
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
      format.js { render "destroy", locals: { id: params[:id] } }
    end
  end

  def wipe
    @participant = Participant.find(params[:id])
    @participant.destroy
    respond_to do |format|
      format.js { render "destroy", locals: { id: params[:id] } }
    end
  end

  def unarchive
    @participant = Participant.unscoped.find(params[:id])
    @participant.archived = false
    @participant.save!
    respond_to do |format|
      format.js { render "destroy", locals: { id: params[:id] } }
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
    logger.info "Received participant form request. Params: #{params}"
    logger.info "Request body: #{request.body.read}"
    participant_param = participant_params
    logger.info "Participant: #{participant_param}"
    if participant_param.nil? || participant_param.empty?
      logger.info "Request has no participant in its parameters. Request failed."
      respond_with('error: "No participant in request parameters."', status: :bad_request, location: @participant) do |format|
        format.json
      end
      return
    else
      event = Event.find_by(unique_id: params[:event_id])
      if event
        @participant = Participant.new(participant_param)
        @participant.role = Role.find_by(name: "Uczestnik")
        @participant.event = event
        days = []
        services = []

        if params[:participant].key?("days")
          params[:participant][:days].each do |paramDay|
            days.push Day.find_by_number(paramDay["number"])
          end
          @participant.days = days
        end

        if params[:participant].key?("services")
          params[:participant][:services].each do |paramService|
            services.push Service.find_by_name(paramService["name"])
          end
          @participant.services = services
        end

        if @participant.save
          respond_with(@participant, status: :created, location: nil) do |format|
            format.json
          end
        else
          logger.info "Saving of participant failed. Responding with 601. Error: #{@participant.errors.to_a.join(', ')}"
          respond_with("error: #{@participant.errors.to_a.join(', ')}", status: 601, location: nil) do |format|
            format.json
          end
        end
      else
        logger.info "Event provided in request not found."
        respond_with('error: "Event provided in request not found."', status: :not_found, location: nil) do |format|
          format.json
        end
      end
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

    parameters = params.permit(:first_name, :last_name, :age, :city, :email, :phone)
    participant = Participant.new(parameters)

    params[:gender] == 'false' ? participant.gender = 'K' : participant.gender = 'M'

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

  def event
    @event ||= Event.find_by(unique_id: params[:event_id].to_s)
  end

  def set_headers
    headers['Access-Control-Allow-Origin'] = 'blu-soft.pl'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
    headers['Access-Control-Max-Age'] = '86400'
  end

  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :email, :gender, :phone, :city, :age, days: [], services: [])
  rescue ActionController::ParameterMissing => e
    nil
  end
end
