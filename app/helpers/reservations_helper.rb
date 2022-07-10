module ReservationsHelper
  #予約数が20以下で
  #予約日が明日以降で
  #定休日ではなければ予約ができるようにする
  def check_reservation(reservations, start_time)
    result = true
    if reservations.count <= 20 && Date.current < start_time && !start_time.saturday? && !start_time.wednesday?
      result
    end
  end
end
