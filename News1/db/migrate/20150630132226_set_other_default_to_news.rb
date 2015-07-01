class SetOtherDefaultToNews < ActiveRecord::Migration
  def change
  	change_column_default :news, :agency, ""
  	change_column_default :news, :image_url, "http://cdn.wonderfulengineering.com/wp-content/uploads/2014/07/background-wallpapers-26.jpg"
  	change_column_default :news, :tags, ""
  	change_column_default :news, :place, ""
  end
end
