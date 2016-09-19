class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t "flash.not_admin"
    redirect_to root_url
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :account_update, keys: [:email,
      :password, :password_confirmation, :current_password, :avatar]
  end

  private

  def current_ability
    namespace = controller_path.split("/").first
    Ability.new current_user, namespace
  end

  def after_sign_in_path_for current_user
    current_user.is_admin? ? admin_root_path : root_path
  end
end
