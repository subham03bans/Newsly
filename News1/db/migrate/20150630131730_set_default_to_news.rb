class SetDefaultToNews < ActiveRecord::Migration
  def change
  	change_column_default :news, :fb_likes, 0
  	change_column_default :news, :tweets, 0
  	change_column_default :news, :google_plus_shares, 0
  	change_column_default :news, :newsly_upvotes, 0
  	change_column_default :news, :newsly_downvotes, 0
  end
end
