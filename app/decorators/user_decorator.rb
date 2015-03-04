class UserDecorator < Draper::Decorator
  delegate_all

  def display_avatar(options = { size: 80 })
    if avatar == 'github'
      avatar_url = "https://avatars.githubusercontent.com/u/#{uid}?s=#{options[:size]}"
    else
      gravatar_id = Digest::MD5.hexdigest(email.downcase)
      avatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    end
    h.image_tag(avatar_url, width: options[:size], alt: name, class: 'img-thumbnail')
  end
end
