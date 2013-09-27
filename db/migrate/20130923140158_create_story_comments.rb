class CreateStoryComments < ActiveRecord::Migration
  def change
    create_table :story_comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :story_id

      t.timestamps
    end
  end
end
