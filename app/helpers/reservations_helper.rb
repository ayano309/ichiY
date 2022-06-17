module ReservationsHelper
  def check_reservation(reservations, start_time)
    result = true
    if reservations.count <= 20 && Date.current < start_time && !(start_time.saturday?)&& !(start_time.wednesday?) 
      return result
    end
  end
end
