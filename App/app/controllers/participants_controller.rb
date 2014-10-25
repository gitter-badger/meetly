class ParticipantsController < ApplicationController

  def index
  end

  def receive_form
    @participant = create_participant

    respond_to do |format|
      if @participant.save
        format.json {render status: :ok, location: @participant}
        format.html {render }
      end
    end
  end

  protected

  def create_participant
    parameters = params.permit(:name, :surname, :age, :city, :email, :phone, :nights, :dinners, :gender)
    participant = Participant.new(parameters)
    days = []
    days.push(Day.find_by_number(1)) if params[:day1]
    days.push(Day.find_by_number(2)) if params[:day2]
    days.push(Day.find_by_number(3)) if params[:day3]
    participant.days = days
    participant
  end
end
