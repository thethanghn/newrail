module UsersHelper
	def gravatar_for(user, size = 40)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "http://0.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		return image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
