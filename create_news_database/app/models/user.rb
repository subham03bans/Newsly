class User < ActiveRecord::Base
#has_many :evaluations, class_name: "RSEvaluation", as: :source
#has_reputation :votes, source: {reputation: :votes, of: :news}, aggregated_by: :sum

#def voted_for?(news)
 # evaluations.where(target_type: news.class, target_id: news.id).present?  
#end


 # has_reputation :votes, source: {reputation: :votes, of: :user}, aggregated_by: :sum
	def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
