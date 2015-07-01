class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :headline
      t.text :content
      t.string :image_url
      t.string :publisher
      t.text :summary
      t.datetime :pub_date
      t.string :agency
      t.integer :fb_likes
      t.integer :tweets
      t.integer :google_plus_shares
      t.integer :newsly_upvotes
      t.integer :newsly_downvotes

      t.timestamps null: false
    end
  end
end
