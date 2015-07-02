class User < ActiveRecord::Base
	has_one :user_history
end
