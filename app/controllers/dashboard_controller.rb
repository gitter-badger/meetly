class DashboardController < ApplicationController
  expose(:participants_with_days_and_services) { current_event.participants.active.includes(:days, :services).references(:days, :services) }
  expose(:participants) { current_event.participants }
end
