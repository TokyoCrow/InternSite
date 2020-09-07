module PagesHelper
MONTHS = %w[nil Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь]

  def rus_name_of_month(date)
    MONTHS[date.month]
  end

  def count_user_events_in_date(event,date)
    event.all.where(date: Date.today.strftime("%Y-%m-%d")).size +
    event.all.where({repeat_every_day: true}).where.not(date: date).size +
    event.all.where({repeat_every_week: true, weekday: date.wday}).where.not(date: date).size +
    event.all.where("date::text LIKE ?", "%-" + date.to_s.split("-")[2]).where({repeat_every_month: true}).where.not(date: date).size +
    event.all.where("date::text LIKE ?", "%-"+ date.to_s.split("-")[1] + "-" + date.to_s.split("-")[2]).where({repeat_every_year: true}).where.not(date: date).size
  end

  def count_another_events_in_date(id,date)
    Event.all.where(date: Date.today.strftime("%Y-%m-%d")).where.not(user_id: id).size +
    Event.all.where({repeat_every_day: true}).where.not(user_id: id).where.not(date: date).size +
    Event.all.where({repeat_every_week: true, weekday: date.wday}).where.not(user_id: id).where.not(date: date).size +
    Event.all.where("date::text LIKE ?", "%-" + date.to_s.split("-")[2]).where({repeat_every_month: true}).where.not(user_id: id).where.not(date: date).size +
    Event.all.where("date::text LIKE ?", "%-"+ date.to_s.split("-")[1] + "-" + date.to_s.split("-")[2]).where({repeat_every_year: true}).where.not(user_id: id).where.not(date: date).size
  end

  def calendar(date = Date.today, &block)
    Calendar.new(self, date, block).table
  end

  class Calendar < Struct.new(:view, :date, :callback)
    HEADER = %w[Пн Вт Ср Чт Пт Сб Вс]

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: "calendar" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        HEADER.map { |day| content_tag :th, day }.join.html_safe
      end
    end

    def week_rows
      weeks.map do |week|
        content_tag :tr do
          week.map { |day| day_cell(day) }.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day)
      content_tag :td, view.capture(day, &callback), class: day_classes(day)
    end

    def day_classes(day)
      classes = []
      classes << "today" if day == Date.today
      classes << "notmonth" if day.month != date.month
      classes.empty? ? nil : classes.join(" ")
    end

    def weeks
      first = date.beginning_of_month.beginning_of_week(:monday)
      last = date.end_of_month.end_of_week.next_week(:sunday)
      weeks = (first..last).to_a.in_groups_of(7).size
      if weeks <= 6
        if weeks == 6
      	  (first..last).to_a.in_groups_of(7)
        else
          last = last.next_week(:sunday)
          (first..last).to_a.in_groups_of(7)
        end
      else
      	last = date.end_of_month.end_of_week(:monday)
      	(first..last).to_a.in_groups_of(7)
      end
    end
  end
end
