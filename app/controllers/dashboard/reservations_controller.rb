class Dashboard::ReservationsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_reservation, only: %i[show edit update destroy]
  layout 'dashboard/dashboard'
  def index
    @reservations = Reservation.all.order(capacity_id: 'desc')
  end

  def show; end


  def edit; end

  def update
    if @reservation.update(reservation_params)
      redirect_to dashboard_reservations_path, notice: '更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @reservation.destroy!
    redirect_to dashboard_reservations_path, notice: '削除に成功しました'
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phone, :number_of_items,  :reservation_day,:reservation_time,:reservation_status,:user_id)
  end
end
