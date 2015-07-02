class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :calculation

  def calculation(dist_norm_array, current_news_distribution, n_distribution)

		@dist_array = Array.new
		

		@dist_norm_array = dist_norm_array
		@current_news_distribution = current_news_distribution
		@n_distribution = n_distribution

		Rails.logger.debug("Checking")
		Rails.logger.debug(current_news_distribution)


		total = dist_norm_array.inject{|sum,x| sum + x }

		

		if total != 0
			dist_norm_array.collect { |n| n/total }
		end


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

end
