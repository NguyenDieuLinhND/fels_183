class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.create_user_success"
      redirect_to admin_root_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :fullname, :email, :password,
      :password_confirmation
  end
end
