class EventsController < ApplicationController
  allow_unauthenticated_access only: %i[show]
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params.merge(creator_id: Current.user.id))

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, status: :see_other, notice: 'Event was successfully destroyed.' }
    end
  end

  private

  def set_event
    @event = Event.find(params.expect(:id))
  end

  def event_params
    params.expect(event: %i[name location start_time end_time maximum_attendees allow_wait_list])
  end
end
