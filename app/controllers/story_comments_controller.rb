class StoryCommentsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy


  def create
    @story_comment = current_user.story_comments.build(params[:story_comment])
    @story = @story_comment.story
    if @story_comment.save
      flash[:success] = "Comment created!"
      redirect_to @story
    else
      render 'stories/show'
    end
  end

  def destroy
    @story = StoryComment.find(params[:id]).story
    StoryComment.find(params[:id]).destroy
    flash[:success] = "Comment deleted!"
    redirect_to @story
  end

  private


    def correct_user
      @story_comment = current_user.story_comments.find_by_id(params[:id])
      redirect_to root_url if @story_comment.nil?
    end
end