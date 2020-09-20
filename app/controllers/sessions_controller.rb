class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password])

    if user
      if login(user)
        redirect_to users_url 
      else
        flash[:errors] ||= []
        flash[:errors] << 'This account has not been activated'
        redirect_to new_session_url
      end
    else
      flash[:errors] ||= []
      flash[:errors] << 'Invalid credentials'
      redirect_to new_session_url
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end