class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @search = User.ransack params[:q]
    @users = @search.nil? ? User.all : @search.result
    @users = @users.order("updated_at DESC").paginate page: params[:page],
      per_page: Settings.size
  end

  def new
    @user = User.new
  end

  def show
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to admin_users_path, notice: t("flash.delete_user")}
      format.js
    end
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
