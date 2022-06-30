# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  category   :integer          not null
#  email      :string           not null
#  message    :text             not null
#  name       :string           not null
#  phone      :string           not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :message, presence: true
  validates :category, presence: true
  validates :status, presence: true

  #一週間分の予約とお問い合わせ
  include Latest

  #予約について、商品について、お店について、その他
  enum category: {
    reserved: 0,
    item: 1,
    shop: 2,
    others: 3
  }
  
  #お問い合わせに対して対応したか
  enum status: {
    unsupported: 0,
    closed: 1
  }
end
