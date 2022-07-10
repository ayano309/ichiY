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
require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'バリデーションのテスト' do
    subject { item.valid? }

    let!(:item) { build(:item) }

    context 'nameカラム' do
      it '空欄でないこと' do
        item.name = ''
        is_expected.to eq false
      end
    end

    context 'descriptionカラム' do
      it '空欄でないこと' do
        item.description = ''
        is_expected.to eq false
      end
    end

    context 'priceカラム' do
      it '空欄でないこと' do
        item.price = ''
        is_expected.to eq false
      end
    end

  end
end
