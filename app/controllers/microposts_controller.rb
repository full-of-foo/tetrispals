class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:destroy]
  
  def index
  end

  def create
  	@micropost = current_user.microposts.build(params[:micropost])
  	@micropost.content = Nokogiri::HTML(@micropost.content).content() if @micropost.content =~ /<.*>/m && Nokogiri::HTML(@micropost.content)
      if @micropost.save
        flash[:success] = "Post created!"
        redirect_to root_url
      else
        @feed_items = current_user.feed.paginate(page: params[:page])
        render 'static_pages/home'
      end
  end

  def destroy
  	@micropost.destroy
    redirect_to :back
  end
  
   private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end
end