class ContactMailer < ApplicationMailer

  def send_mail(mail_title, mail_content, group_users)
    @mail_title = mail_title
    @mail_content = mail_content
  end
end
