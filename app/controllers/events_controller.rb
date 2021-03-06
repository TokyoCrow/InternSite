class EventsController < ApplicationController

  def index
    @divider = 10
    @number_of_events = params[:quantity] ? params[:quantity].to_i : 0
    @event = Event.all.order(created_at: :desc).drop(@number_of_events).take(@divider)
    @events_size = Event.all.size
  end

  def user_events
    @divider = 10
    @number_of_events = params[:quantity] ? params[:quantity].to_i : 0
    @event = Event.all.where(user_id: current_user.id).order(created_at: :desc).drop(@number_of_events).take(@divider)
    @user_events_size = Event.all.where(user_id: current_user.id).size
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
    redirect_to root_path
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
