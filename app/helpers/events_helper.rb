module EventsHelper
  def btns_massive(count,selected_page,divider)
    if count == (count/divider).to_i*divider
      pages = count/divider - 1
    else
      pages = count/divider
    end
    if selected_page < 5
      (0..(pages).to_i).to_a.drop(0).take(5)
    else
      (0..(pages).to_i).to_a.drop(selected_page).take(5)
    end
  end
end
