class HighScoresController < ApplicationController
	before_filter :signed_in_user, only: :create
	before_filter :correct_user, only: :create	
	
	def create
		@high_score = High_Score.new(params(:high_score))
		if @high_score.save
			flash.now[:success] = "Score saved!"
		else
			flash.now[:error] = "Opps!"
		end
	end
end