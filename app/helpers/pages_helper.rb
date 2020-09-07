module PagesHelper
MONTHS = %w[nil Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь]

  def rus_name_of_month(date)
    MONTHS[date.month]
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
