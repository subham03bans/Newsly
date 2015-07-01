class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :google_id, :text, null: false
      t.column :name, :text
      t.timestamps null: false
    end
  end
end
