class PagesController < ApplicationController

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @event = Event.all.where(user_id: current_user.id)
    @events_of_today = all_events_day(Date.today)
    @events_of_day = all_events_day(@date)
  end

  private 

  def all_events_day(date)
    events = date ? @event.all.where(date: date) : @event.all.where(date: Date.today.strftime("%Y-%m-%d"))
    events = events + @event.all.where({repeat_every_day: true}).where.not(date: date)
    events = events + @event.all.where({repeat_every_week: true, weekday: date.wday}).where.not(date: date)
    events = events + @event.all.where("date::text LIKE ?", "%-" + date.to_s.split("-")[2]).where({repeat_every_month: true}).where.not(date: date)
    events = events + @event.all.where("date::text LIKE ?", "%-"+ date.to_s.split("-")[1] + "-" + date.to_s.split("-")[2]).where({repeat_every_year: true}).where.not(date: date)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end