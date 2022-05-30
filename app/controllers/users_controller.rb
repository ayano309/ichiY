class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def show; end

  def mypage; end

  def update_password
    if password_set?
      @user.update_password(user_params)
      flash[:notice] = 'パスワードは正しく変更されました'
      redirect_to root_path
    else
      @user.errors.add(:password, 'パスワードに不備があります。')
      render 'edit_password'
    end
  end

  def edit_password; end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.permit(:name, :email, :phone, :password)
  end

  def password_set?
    user_params[:password].present? ? true : false
  end
end
