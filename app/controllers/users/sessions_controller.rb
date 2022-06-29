# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'guestuserでログインしました。'
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[name phone email password password_confirmation])
  end

  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def reject_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.deleted_flg == true)
        flash[:notice] = '退会済みです。再度ご登録をしてご利用ください。'
        redirect_to new_user_registration_path
      else
        flash[:notice] = '項目を入力してください'
      end
    end
  end
end
