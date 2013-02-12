class HighScoresController < ApplicationController
  before_filter :signed_in_user

  	def index
  		@high_scores = HighScore.all
  	end
	
	def new
		 @high_score = HighScore.new
	end

	def create
			@high_score = HighScore.new(score: params[:high_score][:score], user_id: current_user.id).save
		  respond_to do |format|            
          format.js
          format.html 
      	end	
      	@high_score = HighScore.new	
    end

end