class UsersController < ApplicationController
  before_action :find_user, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(index edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.all.page(params[:page]).per Settings.page.page_item
  end

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
    return if @user
    flash[:danger] = t "static_pages.home.notfound"
    redirect_to root_path
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "static_pages.home.updated"
      redirect_to @user
    else
      flash[:danger] = t "static_pages.home.editedfail"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "static_pages.home.deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user)
          .permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "static_pages.home.please"
    redirect_to login_url
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "static_pages.home.notfound"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
