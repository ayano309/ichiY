class ContactMailer < ApplicationMailer
  def email(contact)
    @contact = contact
    @name = contact.name.present? ? contact.name : contact.email
    mail to: ENV['TOMAIL'], subject: '【お問い合わせ】'
    # mail to: contact.email, subject: '【お問い合わせ】'
  end
end
