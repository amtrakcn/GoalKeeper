class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if !!@user
      session[:token] = @user.reset_token!
      redirect_to users_url
    else
      flash.now[:errors] = []
      flash.now[:errors] << "invalid username or password"
      render :new
    end
  end

  def destroy
    user = self.current_user
    user.reset_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
