module UsersHelper
  def gravatar_for user, option = {size: 80}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = option[:size]
    gravatar_url = user.avatar
    image_tag gravatar_url, alt: user.fullname, class: "gravatar"
  end
end
