class NewsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
  $category = "*"
  def index
  	@all_news = News.all
    $category = "*"
    respond_to do |format|
      format.html { render "index"}
      format.json { render json: @all_news}
    end
  end
  def sports
    $category = "sports"
  	@all_news = News.select("*").where(:category => $category)
   	render "index"
  end
  def business
  	 $category = "business"
     @all_news = News.select("*").where(:category => $category)
  	 render "index"
  end
  def technology
    $category = "tech"  
  	@all_news = News.select("*").where(:category => $category)
  	render "index"
  end
  def entertainment
  	$category = "entertainment"
    @all_news = News.select("*").where(:category => $category)
    respond_to do |format|
      format.html { render "index"}
      format.json { render json: @all_news}
    end
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
  def show
    @all_news = News.select("*").where(:category => $category)
    @display_id= params[:id]
    render 'index'
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
