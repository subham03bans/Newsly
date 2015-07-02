module Api
	module V1
		class NewsController < Api::ApiController
			#before_filter :restrict_access
			#http_basic_authenticate_with name: "admin", password: "secret"

			respond_to :json

			def index
		    	@news = News.all
		    	respond_with :news => @news
		  	end

			def show
				@news = News.select("*").where(:category => params[:id])
			   	respond_with :news => @news
		  	end

		  	def num
		  		@num = News.select("*").where(:category => params[:id]).count
			   	respond_with :num => @num
		  	end

			def new
			  @news = News.new
			  respond_with :news => @news
			end

			def edit
				@news = News.find(params[:id])
				respond_with :news => @news
			end

			def create
				if !News.exists?(headline: params[:headline])
		  			@news = News.new(news_params)
		  			News.summarise(@news)
		  			#apparantely you can do anything before saving the damn thing

		  			if @news.save
			   			respond_with :news => @news
			  		else
			    		respond_with @news.errors
			  		end
		  		end
			end

			def update
			  @news = News.find(params[:id])
			 
			  if @news.update(news_params)
			    respond_with :news => @news
			  else
			    respond_with @news.errors
			  end
			end

			def destroy
			  @news = News.find(params[:id])
			  @news.destroy
			  respond_to do |format|
		      	format.json { head :no_content }
		      end
			end

			def search
			    if params[:q].nil? or params[:q].empty?
			      @all_news = News.all
			    else
			      @all_news = News.search params[:q]
			    end
			     render :json => @all_news
			end

			def autocomplete
			  titles = Array.new
			  if params[:q].nil? or params[:q].empty?
			    puts 'empty' #replace this
			  else
			    news = News.autocomplete params[:q]
			    news.results.each do |t|
			      if t._score > 0.9 
			       titles.push(t._source.title)
			      end
			    end
			  end
			  render :json => titles.to_json  #news.results.to_json #    
			end

			private
			  def news_params
			    params.permit(:category, :headline, :content, :image_url, :pub_date, :publisher)
			  end

		      def restrict_access
				  authenticate_or_request_with_http_token do |token, options|
				    ApiKey.exists?(access_token: token)
				  end
			end
		end
	end
end