class StaticPagesController < ApplicationController
  def home
  	if signed_in?
       redirect_to current_user
    else
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
