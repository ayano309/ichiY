namespace :reservation_status do
  desc '予約日が過ぎたものを予約済みにする'

  task update_reservation_status: :environment do
    # @reservation_day = Reservation.find_by(reservation_day: Time.zone.today)

    @reservation = Reservation.today_reservation_ago.status_visiting.status_update_visited
    
  end
end