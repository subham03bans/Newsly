class NewsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
  def index
  	@all_news = News.all
  end
  def sports
  	@all_news = News.select("*").where(:category => "sports")
  	render "index"
  	#redirect_to :action => :'index'
  end
  def business
  	@all_news = News.select("*").where(:category => "business")
  	render "index"
  end
  def technology
  	@all_news = News.select("*").where(:category => "tech")
  	render "index"
  end
  def entertainment
  	@all_news = News.select("*").where(:category => "entertainment")
  	render "index"
  end

def search
    if params[:q].nil? or params[:q].empty?
      @all_news = News.all
      puts 'nilllllllllll'
    else
      @all_news= News.search params[:q]
      puts 'not nilllllllllll'
      #puts @all_news
    end
      render "index"
  end

def autocomplete
  titles = Array.new
  if params[:q].nil? or params[:q].empty?
    puts 'empty'
  else
    news = News.autocomplete params[:q]
    news.results.each do |t|
      if t._score > 0.9 
       titles.push(t._source.title)
       #titles.push({"title"=>t._source.title,"score"=>t._score})
      end
    end
  end
  render :json => titles.to_json  #news.results.to_json #    
end


  def create
  	if !News.exists?(title: params[:title])
	  	News.new(:category => params[:category], :title => params[:title], :content => params[:content], :url => params[:url]).save
	end
	redirect_to :action => :'index'
  end

end
