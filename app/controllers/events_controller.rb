class EventsController < ApplicationController
  layout 'event_list'
  before_action :authorize_user, except: [:form_data]
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
    event = Event.includes(days: :day_prices, services: :service_prices).find_by(name: query_parameters[:event])
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
    data["registration_status"] = event.registration_status
    data["event_price"] = EventPrice.find_by(event_id: event.id, role_id: role.id, pricing_period_id: current_period.id).price
    data["services"] = []

    ServiceGroup.all.to_a.each do |group|
      if group.services.count > 0
        groupData = {}
        groupData["group"] = group.name
        groupData["items"] = []
        data["services"].push groupData
        group.services.each do |service|
          sp = ServicePrice.find_by(role_id: role.id, service_id: service.id)
          if sp != nil
            spData = {}
            spData["name"] = service.name
            spData["description"] = service.description
            spData["price"] = sp.price
            logger.debug "data: #{data}"
            data["services"].last["items"].push spData
          end
        end
      end
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
