class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.string :state
      t.integer :author_id
      t.integer :responsible_user_id

      t.timestamps
    end
  end
end
