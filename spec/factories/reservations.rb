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
FactoryBot.define do
  factory :reservation do
    
  end
end
