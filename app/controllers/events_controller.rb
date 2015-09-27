class EventsController < ApplicationController
  layout 'event_list'
  respond_to :json

  def index
    @events = Event.all
  end

  def show
    redirect_to event_participants_path(params[:id])
  end

  def form_data
    logger.debug "Received request for form_data for event #{query_parameters[:event]} for role #{query_parameters[:role]}"
    role = Role.find_by(name: query_parameters[:role])
    event = Event.find_by(name: query_parameters[:event])
    if role && event
      form_data = build_form_data_json role, event
      logger.info form_data
      respond_with form_data, status: 200
    else
      respond_with nil, status: 404
    end
  end

  protected

  def query_parameters
    params.permit(:role, :event)
  end

  def build_form_data_json(role, event)
    data = {}
    current_period = PricingPeriod.current_period
    data[:event_price] = event.event_prices.select { |ep| ep.role_id == role.id && ep.pricing_period.id == current_period.id }.first.price
    data[:services] = []
    event.services.each do |service|
      service_pack = {}
      service_pack[:name] = service.name
      service_pack[:price] = service.service_prices.select { |sp| sp.role_id == role.id }.first.price
      data[:services].push service_pack
    end
    data[:days] = []
    event.days.each do |day|
      day_pack = {}
      day_pack[:number] = day.number
      day_pack[:price] = day.day_prices.select { |dp| dp.role_id == role.id && dp.pricing_period_id == current_period.id }.first.price
      data[:days].push day_pack
    end
    data.to_json
  end
end
