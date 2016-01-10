require 'participant_mailer'

class ParticipantsController < ApplicationController
  before_action :set_headers
  before_action :authorize_user, except: [:receive_form, :create_participant]
  respond_to :json, :js

  def index
    @participants = event.participants.includes(:days, :services, :role).active.references(:days, :services, :role).order(:id)
    @days = event.days.sort
    @services = event.services.sort
  end

  def new
    @participant = Participant.new(event: event)
    @days = event.days.sort
    @services = event.services.includes(:service_group).sort_by(&:name).group_by(&:service_group)
  end

  def create
    participant_param = participant_params

    event = Event.find_by(unique_id: params[:event_id])
    @participant = Participant.new(participant_param)
    participant.role = Role.find(params[:participant][:role_id])
    @participant.event = event

    params[:participant][:day_ids] ||= []
    params[:participant][:service_ids] ||= []

    participant.days = Day.none
    participant.services = Service.none

    params[:participant][:day_ids].each do |d|
      participant.days.push(Day.find(d.to_i))
    end

    params[:participant][:service_ids].each do |s|
      participant.services.push(Service.find(s.to_i))
    end

    if participant.save
      respond_to do |format|
        format.json { render json: participant}
        format.js { render js: "window.location.pathname = #{event_participants_path.to_json}" }
      end
    else
      respond_with("error: #{@participant.errors.to_a.join(', ')}", status: 601, location: nil) do |format|
        format.json
      end
    end
  end

  def edit
    participant
    @days = event.days.sort
    @services = event.services.includes(:service_group).sort_by(&:name).group_by(&:service_group)
  end

  def update
    parameters = params.require(:participant).permit(:status, :role_id, :paid, :first_name, :last_name, :gender, :city, :age, :email, :phone, :payment_deadline_at_string)

    participant.role = Role.find(params[:participant][:role_id])

    params[:participant][:day_ids] ||= []
    params[:participant][:service_ids] ||= []

    participant.days = Day.none
    participant.services = Service.none

    params[:participant][:day_ids].each do |d|
      participant.days.push(Day.find(d.to_i))
    end

    params[:participant][:service_ids].each do |s|
      participant.services.push(Service.find(s.to_i))
    end

    participant.assign_attributes(parameters)

    # participant.payment_deadline = DateTime.new(params[:participant]["payment_deadline(1i)"].to_i, params[:participant]["payment_deadline(2i)"].to_i, params[:participant]["payment_deadline(3i)"].to_i)

    if participant.save
      respond_to do |format|
        format.json { render json: participant}
        format.js { render js: "window.location.pathname = #{event_participants_path.to_json}" }
      end
    end
  end

  def destroy
    # TODO
  end

  def set_arrived
    @participant = Participant.find(params[:id])
    participant.status = 'arrived'
    participant.save!
    respond_with(participant, status: :ok, location: nil) do |format|
      format.json
    end
  end

  def calculate_participance_cost
    parameters = params.require(:participant).permit(:status, :role_id, :paid, :first_name, :last_name, :gender, :city, :age, :email, :phone)

    params[:participant][:day_ids] ||= []
    params[:participant][:service_ids] ||= []

    @participant = event.participants.new

    participant.role = Role.find(params[:participant][:role_id])

    participant.days = Day.none
    participant.services = Service.none

    params[:participant][:day_ids].each do |d|
      participant.days.push(Day.find(d.to_i))
    end

    params[:participant][:service_ids].each do |s|
      participant.services.push(Service.find(s.to_i))
    end

    participant.calculate_cost

    participant.assign_attributes(parameters)

    respond_to do |format|
      format.json { render :json => participant.cost }
    end
  end

  def set_status_deleted_and_notify
    @participant = Participant.find(params[:id])
    @participant.status = 'deleted'
    @participant.save!
    send_cancellation_information
    respond_with(@participant, status: :ok, location: nil) do |format|
      format.json
    end
  end

  def set_paid_and_notify
    @participant = Participant.find(params[:id])

    @participant.paid = @participant.cost
    @participant.status = 'paid'
    @participant.save!
    send_payment_confirmation
    respond_to do |format|
      format.json { render :json => @participant}
    end

  end

  def wipe
    @participant = Participant.find(params[:id])
    @participant.destroy
    respond_to do |format|
      format.js { render "destroy", locals: { id: params[:id] } }
    end
  end

  def refresh_statuses
    logger.info "Received refresh status request"
    Participant.where(status: 0).each do |p|
      if(p.payment_deadline - DateTime.now < 0)
        logger.info "Changing status to delayed for #{p.first_name} #{p.last_name}..."
        p.status = 2
        p.save
      end
    end
    respond_with(nil, status: :ok, location: nil) do |format|
      format.json
    end
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
          params[:participant][:days] ||= []
          params[:participant][:days].each do |paramDay|
            days.push Day.find_by_number(paramDay["number"])
          end
          @participant.days = days
        end

        if params[:participant].key?("services")
          params[:participant][:services] ||= []
          params[:participant][:services].each do |paramService|
            services.push Service.find_by_name(paramService["name"])
          end
          @participant.services = services
        end

        if @participant.save
          respond_with(@participant, status: :created, location: nil) do |format|
            format.json
          end
          send_registration_confirmation
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
    send_registration_confirmation @participant
  end

  helper_method :event

  private

  def event
    @event ||= Event.find_by(unique_id: params[:event_id].to_s)
  end

  def participant
    @participant ||= Participant.find(params[:id])
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

  def send_registration_confirmation
    logger.debug "Sending emails disabled."
  end

  def send_cancellation_information
    logger.debug "Sending emails disabled."
  end

  def send_payment_confirmation
    logger.debug "Sending emails disabled."
  end
end
