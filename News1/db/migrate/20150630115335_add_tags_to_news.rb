class AddTagsToNews < ActiveRecord::Migration
  def change
    add_column :news, :tags, :string
  end
end
