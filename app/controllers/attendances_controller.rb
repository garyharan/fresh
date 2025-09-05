class AttendancesController < ApplicationController
  before_action :set_event

  def create
    @attendance = @event.attendances.new(user: Current.user, status: :approved)
    if @attendance.save
      redirect_to @event
    else
      redirect_to @event, alert: 'You could not request attendance.'
    end
  end

  def destroy
    @attendance = @event.attendances.find_by(user: Current.user)
    @attendance&.destroy
    redirect_to @event
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
