class Dashboard::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard/dashboard'
  #ユーザー一覧
  def index
    if params[:keyword].present?
      @keyword = params[:keyword].strip
      @users = User.search_information(@keyword).page(params[:page])
    else
      @keyword = ''
      @users = User.all.order(created_at: :desc).page(params[:page])
    end
  end

  #予約履歴
  def show
    @user = User.find(params[:id])
    @reservations = @user.reservations.order(created_at: :desc).page(params[:page]).per(5)
  end

  #論理削除
  def destroy
    user = User.find(params[:id])
    # userの退会フラグを渡す
    deleted_flg = User.switch_flg(user.deleted_flg)
    user.update(deleted_flg: deleted_flg)
    redirect_to dashboard_users_path
  end
end
