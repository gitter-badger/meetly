class DashboardController < ApplicationController
  expose(:participants) { current_event.participants }
end
