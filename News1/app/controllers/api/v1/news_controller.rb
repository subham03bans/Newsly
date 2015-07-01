module Api
	module V1
		class NewsController < Api::ApiController

			#http_basic_authenticate_with name: "admin" password: "secret"

			respond_to :json

			def index
		    	@news = News.all
		    	respond_with :news => @news
		  	end

			def show
				@news = News.select("*").where(:category => params[:id])
			   	respond_with :news => @news
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

			private
			  def news_params
			    params.permit(:category, :headline, :content, :image_url)
			  end
		end
	end
end