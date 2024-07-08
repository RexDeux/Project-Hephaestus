class SessionsController < ApplicationController

  def create
    @user = User.find_by(username: params[:username])

    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user_id
      redirect_to user_path
    else

      redirect_to login_path, notice: I18n.t('user.error')
    end
  end
end
