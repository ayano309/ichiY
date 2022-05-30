class ReservationMailer < ApplicationMailer
  def email(reservation)
    @reservation = reservation
    @name = reservation.name.present? ? reservation.name : reservation.email
    
    mail to: ENV['TOMAIL'], subject: 'ご予約を受付いたしました'
    # mail to: reservation.email, subject: 'ご予約を受付いたしました'
  end
end