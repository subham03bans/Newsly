class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :calculation
  helper_method :render_news

  def calculation(dist_norm_array, current_news_distribution, n_distribution)

		@dist_array = Array.new
		

		@dist_norm_array = dist_norm_array
		@current_news_distribution = current_news_distribution
		@n_distribution = n_distribution

		Rails.logger.debug("Checking")
		Rails.logger.debug(current_news_distribution)

		if dist_norm_array.max == 0
			final_hash = Hash.new
			final_hash = { 1 => 5, 2 => 5, 3 => 5, 4 => 5, 5 => 5, 6=> 5}
			Rails.logger.debug(final_hash)
			return final_hash
		end

		total = dist_norm_array.inject{|sum,x| sum + x }

		
		dist_norm_array.collect { |n| n/total }


		total = current_news_distribution.inject{|sum,x| sum + x }

		Rails.logger.debug(total)

		if total != 0
			current_news_distribution.collect { |n| n/total }
		end

		i = 0
		while i < @n_distribution
			if @current_news_distribution[i] != 0

				@dist_array[i] = @dist_norm_array[i] / @current_news_distribution[i]
			else
				@dist_array[i] = 0
			end
			i += 1
			Rails.logger.debug("Yo Yo Aman Singh : ")
			Rails.logger.debug(@dist_norm_array[i])
			Rails.logger.debug(@current_news_distribution[i])
		end


		mean = @dist_array.inject{|sum,x| sum + x }

		distribution_array = Hash.new

		i = 1 
		while i <= @n_distribution

			distribution_array[i] = @dist_array[i - 1]
			i+=1

		end

		Rails.logger.debug(distribution_array)
		distribution_array = distribution_array.sort_by {|_key, value| value}.reverse.to_h
		Rails.logger.debug(distribution_array)

		#distribution_array = distribution_array.sort

		mean = mean / @n_distribution
		

		index_array = Array.new
		number_array = Array.new
		j = 0
		i = @n_distribution - 1
 		while i >= 0
 		#	puts(distribution_array[i][0]);
			if distribution_array.values.at(i) - mean > 0 
				#index_array[j] = distribution_array[i][1]
				index_array[j] = distribution_array.keys.at(i)
				#number_array[j] = distribution_array[i][1]
				number_array[j] = distribution_array.values.at(i)
				puts("yoyoyoyo")
				puts(number_array[j])
				j+=1
 			else
				
			end

			i -= 1
		end

		

		i = 0
		temp = number_array.at(0)
		if number_array.at(0) != 0
			while i < j
				number_array[i] = ((number_array[i]*5)/(temp)).floor
				i+=1
			end
		end
		


		final_array = Hash.new

		i=0
		while i< j
			final_array[index_array[i]] = number_array[i]
			puts("bakcbhodi")
			Rails.logger.debug(final_array.keys.at(i))
			puts("ye machau hai")
			Rails.logger.debug(final_array.values.at(i))
			i+=1

		end

		return final_array

	end



	def render_news(history_array)

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
		#news_array = [100.0,100.0,100.0,100.0,100.0,100.0]

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

		return @final_news 
	end

end