class Dashboard::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_guest_user, only: [:destroy]

  layout 'dashboard/dashboard'
  # ユーザー一覧
  def index
    if params[:keyword].present?
      @keyword = params[:keyword].strip
      @users = User.search_information(@keyword).page(params[:page])
    else
      @keyword = ''
      @users = User.order(created_at: :desc).page(params[:page])
    end
  end

  # 予約履歴
  def show
    @user = User.find(params[:id])
    @reservations = @user.reservations.order(created_at: :desc).page(params[:page]).per(5)
  end

  # 論理削除
  def destroy
    user = User.find(params[:id])
    #switch_flgメソッドは、与えられた引数によってtrueまたはfalseを返す。
    deleted_flg = User.switch_flg(user.deleted_flg)
    user.update(deleted_flg: deleted_flg)
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to dashboard_users_path
  end
  private
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to root_path , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
