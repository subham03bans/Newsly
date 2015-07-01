module Api
	class NewsController < Api::ApiController
		respond_to :json

		def index
	    	@news = News.all
	    	respond_with :news => @news
	  	end

		def show
	    	@news = News.find(params[:id])
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
		  @news = News.new(news_params)
		 
		  if @news.save
		    respond_with :news => @news
		  else
		    respond_with @news.errors
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
		    params.require(:news).permit(:headline, :content, :image_url, :publisher, :pub_date, :agency, :summary, :fb_likes, :tweets, :google_plus_shares, :newsly_upvotes, :newsly_downvotes, :category, :place, :tags)
		  end
	end
end