class CreateUserHistories < ActiveRecord::Migration
  def change
    create_table :user_histories do |t|
      t.column :google_id, :text
      t.column :india, :text
      t.column :world, :text
      t.column :business, :text
      t.column :tech, :text
      t.column :sports, :text
      t.column :entertainment, :text
      t.timestamps null: false
      t.belongs_to :users, :index => true
    end
  end
end
