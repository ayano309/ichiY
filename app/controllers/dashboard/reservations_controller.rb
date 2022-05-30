class Dashboard::ReservationsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_reservation, only: %i[show edit update destroy cancel]
  layout 'dashboard/dashboard'
  def index
    @reservations = Reservation.order(reservation_day: 'desc').page(params[:page])
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

  def cancel
    if @reservation.update!(reservation_status: 'cancel')
      redirect_to dashboard_reservations_path, notice: 'キャンセルが完了しました'
    else
      flash.now[:error] = 'キャンセルできませんでした'
      render :show
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phone, :number_of_items,  :reservation_day,:reservation_time,:reservation_status,:user_id)
  end
end
