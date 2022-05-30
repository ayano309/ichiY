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
require 'rails_helper'

RSpec.describe Capacity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
