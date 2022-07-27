module UsersHelper
  def gravatar_for(user, size: 50)
    if user.profile_image.attached?
        processed_key = user.profile_image.variant(resize: "#{size}x#{size}!").processed.key
        full_cdn_url = "#{ENV['AWS_CLOUD_FRONT_URL']}/#{processed_key}"
        image_tag(full_cdn_url, class: "image")
    else 
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "#{ENV['GRAVATAR_URL']}/#{gravatar_id}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar", size: size, class: "image")
    end
  end
end
