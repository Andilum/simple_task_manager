class StoryComment < ActiveRecord::Base
  attr_accessible :content, :story_id, :user_id

  belongs_to :user
  belongs_to :story

  validates :content, presence: true
  validates :user_id, presence: true
  validates :story_id, presence: true

  default_scope order: 'story_comments.created_at DESC'


end
