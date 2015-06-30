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
            fields: ['title^10', 'text']
          }
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          fields: {
            title: {},
            text: {}
          }
        }
      }
    )
  end
end


News.import
