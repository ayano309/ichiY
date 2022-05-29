class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    capacity_id = Capacity.find_by(start_time: params[:reservation][:capacity_id]).id
    # 入力された値(日付)からCapacityテーブルでデータを探し、capacity_idに代入
    Reservation.transaction do
      @reservation = Reservation.create!(reservation_params.merge(capacity_id: capacity_id))
      # 代入したcapacity_idをmerge、外部キーとしてidの値を挿入し予約情報のデータと共に作成、保存
      @reservation.capacity.update!(remaining_seat: @reservation.decreased_capacity)
      # 作成保存した予約情報に紐づく日付の予約上限数の値を更新する処理
      # 予約数上限 - 予約数を計算し、計算結果の予約上限数に更新
    end
    redirect_to reservations_path, success: 'ご予約が完了しました。'
  rescue StandardError
    redirect_to new_reservation_path, danger: 'ご予約ができませんでした。'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phone, :number_of_items, :reservation_time, :reservation_status, :capacity_id, :user_id)
  end
end
