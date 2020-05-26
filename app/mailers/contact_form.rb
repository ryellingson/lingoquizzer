class ContactForm < MailForm::Base
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :file,      :attachment => true

  attribute :subject
  attribute :message
  attribute :nickname,  :captcha  => true #possibly delete ????

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => subject,
      :to => "lingoquizzer@gmail.com",
      :from => %(<#{email}>)
    }
  end
end
