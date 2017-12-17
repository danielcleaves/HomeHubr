class Booking < ApplicationRecord


  after_create_commit :create_notification

  belongs_to :user
  belongs_to :house


  private

  def create_notification
  	type = "New Lead"
  	guest = User.find(self.user_id)

  	Notification.create(content: "#{type} from #{guest.fullname}", user_id: self.house.user_id)
  end

end
