require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  

  describe '予約画面のテスト' do
    before do
      visit reservations_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/reservations'
      end
  end

  context '予約内容' do
    it '利用規約ボタンが存在する' do
      expect(page).to have_link '', href: terms_path
    end
    it 'プライバシーポリシーボタンが存在する' do
      expect(page).to have_link '', href: privacy_path
    end
    it '「ご予約」と表示される' do
      expect(page).to have_content 'ご予約'
    end
    it 'お名前フォームが表示される' do
      expect(page).to have_field 'reservation[name]'
    end
    it 'お名前フォームに値が入っていない' do
      expect(find_field('reservation[name]').text).to be_blank
    end
    it 'メールアドレスフォームが表示される' do
      expect(page).to have_field 'reservation[email]'
    end
    it 'メールアドレスフォームに値が入っていない' do
      expect(find_field('reservation[email]').text).to be_blank
    end
    it '電話番号フォームが表示される' do
      expect(page).to have_field 'reservation[phone]'
    end
    it '電話番号フォームに値が入っていない' do
      expect(find_field('reservation[phone]').text).to be_blank
    end
  end
end
end