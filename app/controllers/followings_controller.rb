class FollowingsController < ApplicationController
  def show
    @title = t "following"
    @user = User.find_by id: params[:id]
    @users = @user.following.all.page(params[:page])
                  .per Settings.page.page_item

    render "users/show_follow"
  end
end
