class ContactMailer < ApplicationMailer
  def email(contact)
    @contact = contact
    @name = contact.name.present? ? contact.name : contact.email
    mail(
      to: contact.email,
      subject: 'お問い合わせを受付いたしました'
    )
  end
end
