class PagesController < ApplicationController

  def index
    @day_divider = 10
    @today_divider = 6
    @number_of_events_today = params[:quantity_today] ? params[:quantity_today].to_i : 0
    @number_of_events_day = params[:quantity_day] ? params[:quantity_day].to_i : 0
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events_of_today = all_events_day(Date.today).drop(@number_of_events_today).take(@today_divider)
    @events_of_day = all_events_day(@date).drop(@number_of_events_day).take(@day_divider)
  end

  private 

  def all_events_day(date)
    events = date ? Event.all.where(date: date) : Event.all.where(date: Date.today.strftime("%Y-%m-%d"))
    events = events + Event.all.where({repeat_every_day: true}).where.not(date: date)
    events = events + Event.all.where({repeat_every_week: true, weekday: date.wday}).where.not(date: date)
    events = events + Event.all.where("date::text LIKE ?", "%-" + date.to_s.split("-")[2]).where({repeat_every_month: true}).where.not(date: date)
    events = events + Event.all.where("date::text LIKE ?", "%-"+ date.to_s.split("-")[1] + "-" + date.to_s.split("-")[2]).where({repeat_every_year: true}).where.not(date: date)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
