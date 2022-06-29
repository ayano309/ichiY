class NotificationFromAdminMailer < ApplicationMailer
  def notify(user, msg)
    @msg = msg
    mail to: user.email, subject: 'ICHIGO大福からのお知らせ'
  end
end