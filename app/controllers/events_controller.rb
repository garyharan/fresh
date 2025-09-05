class EventsController < ApplicationController
  allow_unauthenticated_access only: %i[show]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params.expect(:id))
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Current.user.created_events.find(params.expect(:id))
  end

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
    @event = Current.user.created_events.find(params.expect(:id))

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Current.user.created_events.find(params.expect(:id))
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, status: :see_other, notice: 'Event was successfully destroyed.' }
    end
  end

  private

  def event_params
    params.expect(event: %i[name description location start_time end_time maximum_attendees allow_wait_list])
  end
end
