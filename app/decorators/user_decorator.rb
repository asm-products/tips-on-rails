class UserDecorator < Draper::Decorator
  delegate_all

  def display_avatar(options = { size: 80 })
    avatar_url = "https://avatars.githubusercontent.com/u/#{uid}?s=#{options[:size]}"
    h.image_tag(avatar_url, width: options[:size], alt: name, class: 'img-thumbnail')
  end
end
