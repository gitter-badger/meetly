class DashboardController < ApplicationController
  expose(:participants) { current_event.participants.active.includes(:days, :services) }
end
