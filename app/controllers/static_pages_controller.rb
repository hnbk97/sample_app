class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.page(params[:page])
                                .per Settings.page.page_item
    else
      flash[:warning] = t "static_pages.home.please"
    end
  end

  def help; end

  def about; end
end
