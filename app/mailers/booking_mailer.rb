class BookingMailer < ApplicationMailer
	def send_email_to_buyer(buyer, house)
		@recipient = buyer
		@house = house
		mail(to: @recipient.email, subject: "HomeHubr Lead Purchase")
	end
end