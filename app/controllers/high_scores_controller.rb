class HighScoresController < ApplicationController
  before_filter :signed_in_user

  	def index
  		@leader_scores = HighScore.paginate(page: params[:page], per_page: 10, order: 'score DESC' )
      @high_scores = HighScore.find(:all, :conditions => { :user_id => current_user.id })
    end
	
	def new
		 @high_score = HighScore.new
     @high_scores = HighScore.find(:all, :conditions => { :user_id => current_user.id })
	end

	def create
			@high_score = HighScore.new(score: params[:high_score][:score], user_id: current_user.id)
		  @high_scores = HighScore.find(:all, :conditions => { :user_id => current_user.id })
      if top_score?(@high_score)
        remove_last_top_score
        @high_score.save
        if top_ten_score?(@high_score)
            current_user.microposts.build(content: "Wooooo! I'm now raking #{global_position(@high_score).ordinalize} on the leaderboard!!!").save
            respond_to do |format|            
                format.js { render 'top-score.js.erb' }
              end
            else
            respond_to do |format|            
                format.js { render 'high-score.js.erb' }
              end
        end 
      else
        respond_to do |format| 
          format.js { render 'low-score.js.erb' }
        end
      end
      @high_score = HighScore.new	
  end

end