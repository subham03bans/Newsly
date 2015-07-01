class AddPlaceToNews < ActiveRecord::Migration
  def change
    add_column :news, :place, :string
  end
end
