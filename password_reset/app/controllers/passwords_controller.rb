class PasswordsController < ApplicationController
  def new
  end

  def edit
    @code = params[:code]
  end

def create
  user = User.find_by_email(params[:email])
  if user
    user.set_password_reset
    UserMailer.password_reset(user).deliver_now
    end
    flash[:warning] = 'Password reset sent if email exists'
    redirect_to root_path
    flash[:success] = "Email sent."
  else
    flash[:warning] = "Account not found."
  end

  def update
    user = User.find_by_reset_code(params[:code])
    valid_code = user.expires_at > Time.now.utc
    if user && valid_code && params[:password]
      user.update(password: params[:password], reset_code: nil, expires_at: nil)
      flash[:success] = "Password updated"
      redirect_to login_path
    else
      flash[:warning] = "Incorrect reset code"
      redirect_to root_path
    end
  end
end