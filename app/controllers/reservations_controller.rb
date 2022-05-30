class ReservationsController < ApplicationController
  def index
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      ReservationMailer.email(@reservation).deliver_now
      redirect_to root_path, notice: 'ご予約が完了しました。'
    else
      flash.now[:error] = 'ご予約ができませんでした。'
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phone, :number_of_items, :reservation_day, :reservation_time, :reservation_status, :user_id)
  end
end
