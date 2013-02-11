module ApplicationHelper

	def full_title(title)
		full_title = "Titris Pals"
		if title.empty?
			full_title
		else
			"#{full_title} | #{title}"
		end
	end

end
