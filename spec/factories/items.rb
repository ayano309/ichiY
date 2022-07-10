# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number: 5) }
    description { Faker::Lorem.characters(number: 20) }
    price { 1 }
  end
end
