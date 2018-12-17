class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t "static_pages.home.wel"
      redirect_to @user
    else
      render :new
      flash[:danger] = t "static_pages.home.fail"
    end
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "static_pages.home.notfound"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user)
          .permit :name, :email, :password, :password_confirmation
  end
end
