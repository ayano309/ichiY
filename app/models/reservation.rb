# == Schema Information
#
# Table name: reservations
#
#  id                 :integer          not null, primary key
#  email              :string           not null
#  name               :string           not null
#  number_of_items    :integer          not null
#  phone              :string           not null
#  reservation_status :integer          default(0), not null
#  reservation_time   :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  capacity_id        :integer          not null
#  user_id            :integer
#
# Indexes
#
#  index_reservations_on_capacity_id  (capacity_id)
#  index_reservations_on_user_id      (user_id)
#
# Foreign Keys
#
#  capacity_id  (capacity_id => capacities.id)
#  user_id      (user_id => users.id)
#
class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :capacity
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 256 }
  validates :phone
  validates :number_of_items, presence: true
  validates :reservation_time, presence: true
  validates :reservation_status, presence: true
  validates :capacity_id, presence: true

  validate :date_before_today
  validate :start_time_not_sunday
  validate :start_time_not_monday

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

  def decreased_capacity
    capacity.remaining_item - number_of_items
  end

  def date_before_today
    errors.add(:start_time, 'は過去の日付は選択できません') if capacity.start_time < Time.zone.today
  end

  def start_time_not_saturday
    errors.add(:start_time, 'は定休日(水曜日・土曜日)以外を選択してください') if capacity.start_time.saturday?
  end

  def start_time_not_wednesday
    errors.add(:start_time, 'は定休日(水曜日・土曜日)以外を選択してください') if capacity.start_time.wednesday?
  end
end
