class StoriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :new, :update]
  before_filter :correct_user_destroy,   only: [ :destroy]
  before_filter :correct_user_update,   only: [:update]


  def index
    @q = Story.search(params[:q])
    @stories = @q.result(:distinct => true).paginate(page: params[:page])
  end

  def show
    @story = Story.find(params[:id])
    @story_comment = current_user.story_comments.build if signed_in?
    @comments_list = @story.story_comments
  end

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.build(params[:story])
    if @story.save
      flash[:success] = "Story created!"
      redirect_to @story
    else
      render 'new'
    end
  end

  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(params[:story])
        flash[:success] = "Story updated!"
        redirect_to @story
    else  
      render 'show'
    end
  end

  def destroy
    Story.find(params[:id]).destroy
    flash[:success] = "Story destroyed."
    redirect_to current_user
  end

  private


    def correct_user_destroy
      @story = current_user.stories.find_by_id(params[:id])
      redirect_to root_url if @story.nil?
    end

    def correct_user_update
      @current_story = Story.find_by_id(params[:id])
      @story = current_user.stories.find_by_id(params[:id])
      if current_user!=@current_story.responsible_user && @story.nil?
        redirect_to root_url
      end
    end
end