module ApplicationHelper
  include Pagy::Frontend

  def gravatar_for(user, options = {size: 80})
    email = user.email.downcase
    hash = Digest::MD5.hexdigest(email)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class:"border rounded-lg m-0")
  end

  def flash_color(name)
    if name == "notice"
      return "emerald-600"
    elsif name == "alert"
      return "red-800"
    else
      return "yellow-600"
    end
  end
end
