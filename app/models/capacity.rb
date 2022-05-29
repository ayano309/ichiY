# == Schema Information
#
# Table name: capacities
#
#  id             :integer          not null, primary key
#  remaining_item :integer          default(50), not null
#  start_time     :date             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Capacity < ApplicationRecord
  has_many :reservations
end
