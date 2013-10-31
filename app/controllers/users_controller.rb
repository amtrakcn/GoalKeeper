class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:token] = @user.reset_token!
      redirect_to users_url
    else
      flash.now[:error] = @user.errors.full_message
      render :new
    end
  end

  def index
    render :index
  end
end
