# 予約サイト（ICHIGO大福予約サイト）です。
個人開発で予約サイトを作りたいと思い制作しました。
自分で学んだことをアウトプットしました。

# サービス概要
架空の苺大福専門店です

# なぜ制作したか
私は苺大福が好きです。私がよく行く和菓子屋さんは予約を電話でとっていますが繋がらないことが多々あります。
歯痒い思いがあったので自分で制作に挑戦しようと思いました。

# 難しかった機能
- 人数制限と休みの日は予約ができないようにする
- SimpleCalenderから予約する
- 確認画面の実装
 
# 主な機能

## 一般ユーザー
* User ログイン機能
* ゲストログイン機能
* 退会機能
* アカウント編集
* パスワード変更機能
* 予約機能(ログインしていなくても予約できる)
* 予約履歴表示
* お問い合わせ機能

## 管理ユーザー
* 管理者ゲストログイン機能
* 論理削除
* 商品を登録する機能
* 顧客一覧
* 予約一覧
* お問い合わせ一覧
* 予約カレンダー
* 予約ステータス	


# 使用技術
## バックエンド
 * Ruby 2.7.5p203 (2021-11-24 revision f69aeb8314) [arm64-darwin20]
 * Rails 6.1.5
 * Rubocop
## フロントエンド
* HTML
* CSS(SCSS)
* JavaScript(jQuery)
* bootstrap4

# 主な Gem
* gem 'devise'
* gem 'kaminari'
* gem 'better_errors'
* gem 'binding_of_caller'
* gem 'pry-byebug'
* gem 'rspec-rails'
* gem 'factory_bot_rails'
* gem 'rubocop'
* gem 'rubocop-rails'
* gem 'dotenv-rails'
* gem 'faker'
* gem 'annotate'
* gem 'enum_help'
* gem 'rails-i18n'
* gem 'simple_calendar'

# 今後実装したいこと
- セットで販売した際の個数制限（現段階では１日２０件まで予約可能にしているため）
- 定休日設定
- NEWS（お店からのお知らせ）
