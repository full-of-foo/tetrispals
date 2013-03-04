module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar", size: size)
  end

  def geo_address(ip_v4)
  	Geocoder.search(ip_v4)[0].country != "Reserved" ? "#{Geocoder.search(ip_v4)[0].country},  #{Geocoder.search(ip_v4)[0].city}" : ""
  end

end
