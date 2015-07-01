class LoginController < ApplicationController

	skip_before_filter  :verify_authenticity_token
	
	def receives_data
		
		#@request = Request.new(params[:myHttpData])
    	#if @request.save
    	#  redirect_to @request
    	#else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      #render "recieves_data"

    #end

    	Rails.logger.debug(params[:myHttpData])

	    if params[:myHttpData] == "51"
	    	Rails.logger.debug("hahaha")
	    	render :json => { :error => 0 , :success => 1 } 
	    else
	    	Rails.logger.debug("My object:" )
	    	render :json => { :error => 1 , :success => 0 } 
		end
	end

end
