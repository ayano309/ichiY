class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 2..20 }
  validates :email, presence: true
  validates :phone, presence: true

  def update_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  scope :search_information, -> (keyword) { 
    where("name LIKE :keyword OR id LIKE :keyword OR email LIKE :keyword OR phone LIKE :keyword", keyword: "%#{keyword}%")
  }
end
