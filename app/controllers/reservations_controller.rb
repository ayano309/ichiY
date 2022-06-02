class ReservationsController < ApplicationController
  def index
    @items = Item.all
    @reservation = Reservation.new
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    return unless @reservation.invalid?
    flash.now[:error] = 'ご来店日は水曜日、土曜日以外の日付を選択して下さい。'
    @items = Item.all
    render :index
  end
  
  def back
    @items = Item.all
    @reservation = Reservation.new(reservation_params)
    render :index
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      ReservationMailer.email(@reservation).deliver_now
      redirect_to root_path, notice: 'ご予約が完了しました。'
    else
      flash.now[:error] = 'ご予約ができませんでした。'
      @items = Item.all
      render :index
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phone, :number_of_items, :reservation_day, :reservation_time, :reservation_status, :user_id)
  end
end
