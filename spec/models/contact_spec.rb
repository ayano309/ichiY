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
require 'rails_helper'

RSpec.describe Contact, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
