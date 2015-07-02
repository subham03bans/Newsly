class SetDefaultsToNews < ActiveRecord::Migration
  def change
  	change_column_default :news, :fb_likes, 0
  	change_column_default :news, :tweets, 0
  	change_column_default :news, :google_plus_shares, 0
  	change_column_default :news, :newsly_upvotes, 0
  	change_column_default :news, :newsly_downvotes, 0
  	change_column_default :news, :agency, ""
  	change_column_default :news, :image_url, "http://wallpaper-download.net/wallpapers/random-wallpapers-plain-blue-wallpaper-wallpaper-33973.jpg"
  	change_column_default :news, :tags, ""
  	change_column_default :news, :place, ""
  end
end
