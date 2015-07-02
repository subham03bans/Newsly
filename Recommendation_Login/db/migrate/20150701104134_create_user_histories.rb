class CreateUserHistories < ActiveRecord::Migration
  def change
    create_table :user_histories do |t|
      t.column :google_id, :text
      t.column :india, :integer
      t.column :world, :integer
      t.column :business, :integer
      t.column :tech, :integer
      t.column :sports, :integer
      t.column :entertainment, :integer
      t.timestamps null: false
      t.belongs_to :users, :index => true
    end
  end
end
