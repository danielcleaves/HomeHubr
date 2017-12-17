module ApplicationHelper
  def avatar_url(user)
    return user.image.url(:medium) if user.image?

    if user.fb_image
      "http://graph.facebook.com/#{user.uid}/picture?type=large"
    else
      gravatar_id = Digest::MD5.hexdigest(user.email).downcase
      "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?s=150"
    end
  end
end
