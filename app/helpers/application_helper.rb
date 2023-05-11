module ApplicationHelper

  def gravatar_for(user, options = {size: 80})
    email = user.email.downcase
    hash = Digest::MD5.hexdigest(email)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username)
  end

  def flash_color(name)
    if name == "notice"
      return "green"
    elsif name == "alert"
      return "red"
    else
      return "yellow"
    end
  end

end
