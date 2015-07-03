class RecommendationController < ApplicationController
	skip_before_filter  :verify_authenticity_token

	def check_packet

		@add = 'http://10.1.2.154:3000/api/news/'

    	@google_id = params[:google_id];
    	@name = params[:name];

    	#@record = User.where(:google_id => @google_id).present?
    	#@record = User.count( :google_id => @google_id)

    	@record = User.exists?(:google_id => @google_id)

    	Rails.logger.debug("Check : ")
    	Rails.logger.debug(@record)
    	Rails.logger.debug("End ")



    	if !@record
    		Rails.logger.debug("Not present ")
    		#redirect_to :controller => 'login', :action => 'receives_data', :google_id => @google_id, :name => @name and return
    		#@post = :controller => 'login', :action => 'receives_data', :google_id => @google_id, :name => @name
    		#redirect_to post_url(@post)
    		@user = User.new(:google_id => @google_id, :name => @name)

    		
    		
			if @user.save
			  @uid = User.where(:google_id => @google_id ).first.id
			  #Rails.logger.debug(@uid)
    		  @hist = UserHistory.new(:google_id => @google_id, :india => 0, :world => 0, :business => 0,:tech => 0, :sports => 0, :entertainment => 0, :users_id => @uid);
    		  @hist.save

    		  hist_array = [ 0, 0, 0, 0, 0, 0]

    		  #Rails.logger.debug(@final_news);
    		  @final_news = render_news(hist_array)
    		  render :json => @final_news
      		  
			end

    	else
    		Rails.logger.debug("Purana user hai ye. Recommend karo");

    		hist_array = Array.new(6)
    		history  = UserHistory.where(:google_id => @google_id ).first
    		Rails.logger.debug(history.india);
    		hist_array = [history.india , history.world, history.business, history.tech, history.sports, history.entertainment ]
    		@final_news = render_news(hist_array)
    		render :json => @final_news
    	end

	end

end
