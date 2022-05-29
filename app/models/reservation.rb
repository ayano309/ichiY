# == Schema Information
#
# Table name: reservations
#
#  id                 :integer          not null, primary key
#  email              :string           not null
#  name               :string           not null
#  number_of_items    :integer          not null
#  phone              :string           not null
#  reservation_day    :date             not null
#  reservation_status :integer          default("visiting"), not null
#  reservation_time   :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#
# Indexes
#
#  index_reservations_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  
  validates :name, presence: true
  validates :email, presence: true
  validates :phone,presence: true
  validates :number_of_items, presence: true
  validates :reservation_day, presence: true
  validates :reservation_time, presence: true
  validates :reservation_status, presence: true

  validate :date_before_today
  validate :reservation_day_not_sunday
  validate :reservation_day_not_monday

  enum reservation_time: {
    '11:00': 0,
    '11:15': 1,
    '11:30': 2,
    '11:45': 3,
    '12:00': 4,
    '12:15': 5,
    '12:30': 6
  }

  enum reservation_status: {
    visiting: 0,
    visited: 1,
    cancel: 2
  }

  
  def date_before_today
    errors.add(:reservation_day, 'は過去の日付は選択できません') if reservation_day < Time.zone.today
  end

  def reservation_day_not_sunday
    errors.add(:reservation_day, 'は定休日(月曜日・日曜日)以外を選択してください') if reservation_day.sunday?
  end

  def reservation_day_not_monday
    errors.add(:reservation_day, 'は定休日(月曜日・日曜日)以外を選択してください') if reservation_day.monday?
  end
end
