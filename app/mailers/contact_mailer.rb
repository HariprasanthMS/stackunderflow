class ContactMailer < ApplicationMailer
  default from: 'hariprasanth@chronus.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.send_notification.subject
  #
  def send_notification(name, email, message)
    @greeting = "Hi #{name},"
    @message = message
    mail subject: 'Answer notification'
    mail to: email
  end
end
