class Story < ActiveRecord::Base
  attr_accessible :author_id, :description, :responsible_user_id, :state, :title

  has_many :story_comments
  
  belongs_to :author, class_name: "User"
  belongs_to :responsible_user, class_name: "User"

  validates :author_id, presence: true
  validates :state, presence: true
  validates :title, presence: true

  self.per_page = 15

  default_scope order: 'stories.created_at DESC'

  def self.from_following_for(user)
    where("responsible_user_id = :user_id or author_id =  :user_id", user_id: user)
  end


  private
    def user=(user)
      self.author = user
    end

end
