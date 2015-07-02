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


      		  require 'open-uri' 
			  @response = open(@add+'india').read
			  @data = JSON.parse(@response)
			  @india = @data["news"]

			  require 'open-uri' 
			  @response = open(@add+'tech').read
			  @data = JSON.parse(@response)
			  @tech = @data["news"]

			  require 'open-uri' 
			  @response = open(@add+'sports').read
			  @data = JSON.parse(@response)
			  @sports = @data["news"]

			  require 'open-uri' 
			  @response = open(@add+'world').read
			  @data = JSON.parse(@response)
			  @world = @data["news"]

			  require 'open-uri' 
			  @response = open(@add+'entertainment').read
			  @data = JSON.parse(@response)
			  @entertainment = @data["news"]

			  require 'open-uri' 
			  @response = open(@add+'business').read
			  @data = JSON.parse(@response)
			  @business = @data["news"]

			  news_array = [@india.length , @tech.length , @sports.length , @world.length , @entertainment.length , @business.length]
			  news_array = [100.0,100.0,100.0,100.0,100.0,100.0]
			  history_array = [10.0 ,100.0 ,10.0 ,10.0 ,9.0, 100.0]
			  
			  count = 6

			  final_hash = calculation(history_array, news_array, count)

			  require 'open-uri' 
			  @response = open(@add).read
			  parsed_json = ActiveSupport::JSON.decode(@response)

			  @final_news = Array.new

			  i = 0
			  k = 0
			  puts('checking')
			  puts(final_hash.keys.length)

			  while i < final_hash.keys.length
			  	puts('check for i :')
			  	puts(i)
			  	puts(final_hash.keys.at(i))
			  	case final_hash.keys.at(i)
			  	when 1
			  		j = 0
			  		while j < final_hash.values.at(i)
			  			@final_news[k]  = @india.at(j)
			  			k += 1
			  			j += 1
			  			puts("india")
			  			puts(j)
			  			puts(k)
			  		end

			  	when 2
			  		j = 0
			  		while j < final_hash.values.at(i)
			  			@final_news[k]  = @tech.at(j)
			  			k += 1
			  			j += 1
			  			puts("tech")
			  			puts(j)
			  			puts(k)
			  		end

			  	when 3
			  		j = 0
			  		while j < final_hash.values.at(i)
			  			@final_news[k] = @sports.at(j)
			  			k += 1
			  			j += 1
			  			puts("sports")
			  			puts(j)
			  			puts(k)
			  		end

			  	when 4
			  		j = 0
			  		while j < final_hash.values.at(i)
			  			@final_news[k]  = @world.at(j)
			  			k += 1
			  			j += 1
			  			puts("world")
			  			puts(j)
			  			puts(k)
			  		end

			  	when 5
			  		j = 0
			  		while j < final_hash.values.at(i)
			  			@final_news[k]  = @entertainment.at(j)
			  			k += 1
			  			j += 1
			  			puts("entertainment")
			  			puts(j)
			  			puts(k)
			  		end

			  	when 6
			  		j = 0
			  		while j < final_hash.values.at(i)
			  			@final_news[k]  = @business.at(j)
			  			k += 1
			  			j += 1
			  			puts("business")
			  			puts(j)
			  			puts(k)
			  		end

			  	end
			  	i += 1
			  end
			end

			#Rails.logger.debug(@final_news);
    		
    		render :json => @final_news

    	else
    		Rails.logger.debug("Purana user hai ye. Recommend karo");
    	end

	end

end
