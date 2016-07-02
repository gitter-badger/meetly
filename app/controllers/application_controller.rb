class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :current_event

  def redirect_to_events_list
    redirect_to events_path
  end

  private

  def current_event
    Event.find_by(unique_id: params[:event_id].to_s)
  end
end
