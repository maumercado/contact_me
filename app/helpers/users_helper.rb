module UsersHelper
  # Returns Gravatar for the given user.
  def avatar_for(someuser, options = { size: 80 })
    if someuser.twitter.nil? or someuser.twitter.blank?
      gravatar_id = Digest::MD5::hexdigest(someuser.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: someuser.name, class: "gravatar")
    else
      twitter_user = Twitter.user(someuser.twitter)
      profile_image_url = twitter_user.profile_image_url
      profile_image_url.slice! "_normal"
      image_tag(profile_image_url, size: "80x80", alt: someuser.name, class: "gravatar")
    end
  end
end
