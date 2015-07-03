class LoginController < ApplicationController

	skip_before_filter  :verify_authenticity_token
	
	def receives_data

    	Rails.logger.debug(params[:name])

	    if params[:google_id] == "51"
	    	Rails.logger.debug("hahaha")
	    	render :json => { :error => 0 , :success => 1 } 
	    else
	    	Rails.logger.debug(params[:google_id])
	    	render :json => { :error => 1 , :success => 0 } 
		end

		@google_id = params[:google_id]
		@name = params[:name]

		@user = User.new(:google_id => @google_id, :name => @name)

		if @user.save
    	  Rails.logger.debug(@user.google_id)


	    else
	      render :json => { :error => 1, :success => 0 } 
	    end

	end

	

end
