require 'rails_helper'


describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'Log inリンクが表示される: ボタンの表示が「Log in」である' do
        log_in_link = find_all('a')[6].native.inner_text
        expect(log_in_link).to match(/Log in/)
      end
      it 'Log inリンクの内容が正しい' do
        log_in_link = find_all('a')[6].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      it 'Sign upリンクが表示される: 緑色のボタンの表示が「Sign up」である' do
        sign_up_link = find_all('a')[5].native.inner_text
        expect(sign_up_link).to match(/Sign up/)
      end
      it 'Sign upリンクの内容が正しい' do
        sign_up_link = find_all('a')[5].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit '/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'Reservationリンクが表示される: 左上から3番目のリンクが「Reservation」である' do
        reservation_link = find_all('a')[2].native.inner_text
        expect(reservation_link).to match(/Reservation/)
      end
      it 'Aboutリンクが表示される: 左上から4番目のリンクが「About」である' do
        about_link = find_all('a')[3].native.inner_text
        expect(about_link).to match(/About/)
      end
      it 'Contactリンクが表示される: 左上から5番目のリンクが「Contact」である' do
        contact_link = find_all('a')[4].native.inner_text
        expect(contact_link).to match(/Contact/)
      end
      it 'Sign upリンクが表示される: 左上から6番目のリンクが「新規登録」である' do
        signup_link = find_all('a')[5].native.inner_text
        expect(signup_link).to match(/新規登録/)
      end
      it 'Log inリンクが表示される: 左上から7番目のリンクが「ログイン」である' do
        login_link = find_all('a')[6].native.inner_text
        expect(login_link).to match(/ログイン/)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }
      
      it 'ICHIGO大福を押すと、トップ画面に遷移する' do
        home_link = find_all('a')[0].native.inner_text
        home_link = home_link.delete(' ')
        home_link.gsub!(/\n/, '')
        click_link home_link
        is_expected.to eq '/'
      end
      it 'TOPを押すと、トップ画面に遷移する' do
        home_link = find_all('a')[1].native.inner_text
        home_link = home_link.delete(' ')
        home_link.gsub!(/\n/, '')
        click_link home_link
        is_expected.to eq '/'
      end
      it 'Reservationを押すと、アバウト画面に遷移する' do
        reservation_link = find_all('a')[2].native.inner_text
        reservation_link = reservation_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link reservation_link
        is_expected.to eq '/reservations'
      end
      it 'Aboutを押すと、アバウト画面に遷移する' do
        about_link = find_all('a')[3].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it 'Contactを押すと、アバウト画面に遷移する' do
        contact_link = find_all('a')[4].native.inner_text
        contact_link = contact_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link contact_link
        is_expected.to eq '/contacts'
      end
      it 'Sign upを押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[5].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link, match: :first
        is_expected.to eq '/users/sign_up'
      end
      it 'Log inを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[6].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link, match: :first
        is_expected.to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「新規会員登録」と表示される' do
        expect(page).to have_content '新規会員登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'phoneフォームが表示される' do
        expect(page).to have_field 'user[phone]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[phone]', with: '023-456-789'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
      it 'nameフォームは表示されない' do
        expect(page).not_to have_field 'user[name]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が、top画面になっている' do
        expect(current_path).to eq '/'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[name]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    context 'ヘッダーの表示を確認' do
      it 'Reservationリンクが表示される: 左上から3番目のリンクが「Reservation」である' do
        reservation_link = find_all('a')[2].native.inner_text
        expect(reservation_link).to match(/Reservation/)
      end
      it 'Aboutリンクが表示される: 左上から4番目のリンクが「About」である' do
        about_link = find_all('a')[3].native.inner_text
        expect(about_link).to match(/About/)
      end
      it 'Contactリンクが表示される: 左上から5番目のリンクが「Contact」である' do
        contact_link = find_all('a')[4].native.inner_text
        expect(contact_link).to match(/Contact/)
      end
      it 'マイページリンクが表示される: 左上から6番目のリンクが「マイページ」である' do
        mypage_link = find_all('a')[5].native.inner_text
        expect(mypage_link).to match(/マイページ/)
      end
      it 'ログアウトリンクが表示される: 左上から7番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[6].native.inner_text
        expect(logout_link).to match(/ログアウト/)
      end
    end
  end


  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      logout_link = find_all('a')[4].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてTOP画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end