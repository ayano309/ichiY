class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to root_path, notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phone, :number_of_items,  :reservation_day,:reservation_time,:reservation_status,:user_id)
  end
end