class FollowersController < ApplicationController
  def show
    @title = t "followers"
    @user = User.find_by id: params[:id]
    @users = @user.followers.all.page(params[:page])
                  .per Settings.page.page_item
    render "users/show_follow"
  end
end
