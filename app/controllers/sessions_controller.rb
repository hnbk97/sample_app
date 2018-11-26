class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      if user.activated?
        login_remember user
      else
        flash[:warning] = t "account_not_activated"
        redirect_to root_url
      end
    else
      flash[:danger] = t "sessions.new.invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def login_remember user
    log_in user
    if params[:session][:remember_me] == Settings.remember.yeah
      remember user
    else
      forget user
    end
    redirect_back_or user
  end
end
