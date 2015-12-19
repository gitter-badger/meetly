class DashboardController < ApplicationController
  expose(:participants) { current_event.participants.includes(:days, :services) }
end
