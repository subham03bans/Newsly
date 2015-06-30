class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :category
      t.string :title
      t.text :content
      t.string :url

      t.timestamps null: false
    end
  end
end
