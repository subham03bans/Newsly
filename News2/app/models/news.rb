require 'stanford-core-nlp'

	class News < ActiveRecord::Base

		include Elasticsearch::Model
	  	include Elasticsearch::Model::Callbacks

	  	 def self.search(query)
	    __elasticsearch__.search(
	      {
	        query: {
	          multi_match: {
	            query: query,
	            fields: ['headline^10', 'content']
	          }
	        }

	      }
	    )

	  end

	  def self.disp(news)
	  	news.each do |item|
	  		puts item.headline
	  	end
	  end


	    def self.autocomplete(query)
	    __elasticsearch__.search(
	     {
	      query: {
	          multi_match: {
	            query: query,
	            fields: ['headline']
	          }
	        }
	     }
	      )
	  end

	  ##TODO
		def self.summarise(news)
			# Use the model files for a different language than English.
			StanfordCoreNLP.use :french # or :german

			text = 'Angela Merkel met Nicolas Sarkozy on January 25th in ' +
			   'Berlin to discuss a new austerity package. Sarkozy ' +
			   'looked pleased, but Merkel was dismayed.'

			pipeline =  StanfordCoreNLP.load(:tokenize, :ssplit)
			text = StanfordCoreNLP::Annotation.new(text)
			pipeline.annotate(text)

			text.get(:sentences).each do |sentence|
				puts "Yo Yo!! "
				puts sentence
			  # Syntatical dependencies
			  #puts sentence.get(:basic_dependencies).to_s
			 # sentence.get(:tokens).each do |token|
			    # Default annotations for all tokens
			   # puts token.get(:value).to_s
			   # puts token.get(:original_text).to_s
			    #puts token.get(:character_offset_begin).to_s
			    #puts token.get(:character_offset_end).to_s
			  #end
			end
			news.summary = "Hello Beautiful World!!"
		end
	end

	News.import
