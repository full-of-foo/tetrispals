module HighScoresHelper
	
	def is_top_score?(high_score)
		current_user.high_scores.sort_by { |high_s| high_s.score }.first.score < high_score.score
	end

	def remove_last_top_score
		current_user.high_scores.sort_by { |high_s| high_s.score }.first.destroy
	end
end