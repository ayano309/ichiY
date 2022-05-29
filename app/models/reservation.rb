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
  belongs_to :user
  belongs_to :capacity
end
