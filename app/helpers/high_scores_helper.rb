module HighScoresHelper
	
	def top_score?(high_score)
		current_user.high_scores.sort_by { |high_s| high_s.score }.first.score < high_score.score
	end

	def remove_last_top_score
		current_user.high_scores.sort_by { |high_s| high_s.score }.first.destroy
	end

	def top_score(user)
		HighScore.find(:all, conditions: { user_id: user.id }).sort_by { |hs| hs.score }.last
	end

	def global_position(score)
		HighScore.all.sort_by { |high_s| high_s.score }.reverse.index(score) + 1
	end

	def top_ten_score?(high_score)
		global_position(high_score) < 11
	end

	def viewing_trophy_user(user)
		@user = current_user unless @user
	end

end