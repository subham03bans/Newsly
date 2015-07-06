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

	  def self.source(news)
	  	formattedJson = Array.new;
	  	news.each do |item|
	  		formattedJson.push(item._source)
	  	end
	  	res = formattedJson
	  end

	  ##TODO
		def self.summarise(news)
			# Use the model files for a different language than English.
			StanfordCoreNLP.use :english # or :german

			text = news.content

			pipeline =  StanfordCoreNLP.load(:tokenize, :ssplit)
			text = StanfordCoreNLP::Annotation.new(text)
			pipeline.annotate(text)

			summ_sentences = text.get(:sentences).to_a
			summ_sentences.each do |sentence|
				sentence = sentence.to_s
			end

			summ_len = [3,summ_sentences.length].min

			news.summary = summ_sentences[0,summ_len-1].join(' ')
		end
	end

	News.import
