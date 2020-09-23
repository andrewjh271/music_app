class UsersController < ApplicationController
  before_action :require_user, only: :show

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      msg = UserMailer.confirmation_email(@user)
      msg.deliver_now
      flash[:notice] = 'Please check your email to activate your account.'
      redirect_to bands_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def activate
    user = User.find_by(activation_token: params[:activation_token])
    if user
      user.update(activated: true)
      login(user)
      render :activated
    else
      render plain: 'Activation was unsuccessful'
    end
  end

  def show
    @user = current_user
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end