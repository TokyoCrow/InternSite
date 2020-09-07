class EventsController < ApplicationController

  def index
    @event = Event.all.order(created_at: :desc)
  end

  def user_events
    @event = Event.all.where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @event = Event.new
    @event.date = Date.today
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end

  def edit
    if Event.find(params[:id])[:user_id] == current_user.id
      @event = Event.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    render 'user_events'
  end


  private
  def event_params
    repeat = Array.new(5, false)
    repeat[params.require(:repeat).to_i] = true
    arguments = params.require(:event).permit(:title, :discription, :date)
    time_a = arguments[:date].split('-')
    time = Time.new(time_a[0],time_a[1],time_a[2])
    arguments[:repeat_every_day] = repeat[1]
    arguments[:repeat_every_week] = repeat[2]
    arguments[:repeat_every_month] = repeat[3]
    arguments[:repeat_every_year] = repeat[4]
    arguments[:weekday] = time.wday
    return arguments
  end
end
