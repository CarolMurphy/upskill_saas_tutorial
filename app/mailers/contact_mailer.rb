class ContactMailer < ActionMailer::Base
  #added but not activated.
  #Mail Server Mailgun not installed yet
  default to: 'c_murph@comcast.net'
  
  def contact_email(name, email, body)
    @name = name
    @email = email
    @body = body
    
    mail(from: email, subject: 'Contact Form Message')
  end
end