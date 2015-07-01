require 'elasticsearch/model'

class News < ActiveRecord::Base
	include Elasticsearch::Model
  	include Elasticsearch::Model::Callbacks

  	 def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'content']
          }
        }

      }
    )

  end


    def self.autocomplete(query)
    __elasticsearch__.search(
     {
      query: {
          multi_match: {
            query: query,
            fields: ['title']
          }
        }
     }
      )
  end
end

News.import
