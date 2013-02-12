class HighScoresController < ApplicationController
  before_filter :signed_in_user

  	def index
  		@high_scores = HighScore.all
  	end
	
	def new
		 @high_score = HighScore.new
     @high_scores = HighScore.find(:all, :conditions => { :user_id => current_user.id })
	end

	def create
			@high_score = HighScore.new(score: params[:high_score][:score], user_id: current_user.id)
		  @high_scores = HighScore.find(:all, :conditions => { :user_id => current_user.id })
      if is_top_score?(@high_score)
        remove_last_top_score
        @high_score.save
        respond_to do |format|            
            format.html
            format.js
          end 
      else
        respond_to do |format| 
          format.js { render 'low-score.js.erb' }
        end
      end
      @high_score = HighScore.new	
  end

end