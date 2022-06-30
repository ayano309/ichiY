class NotificationFromAdminJob < ApplicationJob
  queue_as :default
  #お店からのお知らせを非同期メールにした
  def perform(msg)
    User.all.each do |user|
      NotificationFromAdminMailer.notify(user, msg).deliver_later
    end
  end
end