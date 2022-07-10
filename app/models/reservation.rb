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
  validates :phone, presence: true
  validates :number_of_items, presence: true
  validates :reservation_day, presence: true
  validates :reservation_time, presence: true
  validates :reservation_status, presence: true

  # 新規予約作成時のみ過去日付を選択できないようにon: :createにする
  # あとでステータス変更するため
  validate :date_before_today, on: :create
  validate :reservation_day_not_saturday
  validate :reservation_day_not_wednesday

  include Latest
  #予約時間
  enum reservation_time: {
    '11:00': 0,
    '11:15': 1,
    '11:30': 2,
    '11:45': 3,
    '12:00': 4,
    '12:15': 5,
    '12:30': 6
  }
  #予約ステータス(予約、受取済、キャンセル)
  enum reservation_status: {
    visiting: 0,
    visited: 1,
    cancel: 2
  }

  #validation(過去の日、定休日)
  def date_before_today
    errors.add(:reservation_day, 'は過去の日付は選択できません') if reservation_day < Time.zone.today
  end

  def reservation_day_not_saturday
    errors.add(:reservation_day, 'は定休日(水曜日・土曜日)以外を選択してください') if reservation_day.saturday?
  end

  def reservation_day_not_wednesday
    errors.add(:reservation_day, 'は定休日(水曜日・土曜日)以外を選択してください') if reservation_day.wednesday?
  end

  #simple_calender
  def start_time
    reservation_day.to_time.to_datetime
  end


  # raketask(予約日過ぎたもので予約ステータス全てを受取済に変更する)
  scope :today_reservation_ago, -> { where('reservation_day <= ?', Time.zone.today) }
  scope :status_visiting, -> { where(reservation_status: 'visiting') }
  scope :status_update_visited, -> { update(reservation_status: 'visited') }
end
