# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  deleted_flg            :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  phone                  :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'ユーザー名、メールアドレス、電話番号、パスワードがある場合、有効' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'ユーザー名がない場合、無効' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'ユーザー名が21文字以上、無効' do
      user = build(:user, name: 'a' * 21)
      user.valid?
      expect(user.errors[:name]).to include('は20文字以内で入力してください')
    end

    it 'メールアドレスがない場合、無効' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it '電話番号がない場合、無効' do
      user = build(:user, phone: nil)
      user.valid?
      expect(user.errors[:phone]).to include('を入力してください')
    end
  end

  
end
