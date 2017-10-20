class ContactMailer < ApplicationMailer
  def contact_us(opts = {})
    @recipient = 'admin@homehubr.com'
    @first_name = opts[:first_name]
    @last_name = opts[:last_name]
    @email = opts[:email]
    @phone_number = opts[:phone_number]
    @message = opts[:message]

    mail(to: @recipient, subject: "Message from #{@first_name} #{@last_name}", from: @email)
  end
end
