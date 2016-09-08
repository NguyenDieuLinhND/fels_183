class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def current_ability
    namespace = controller_path.split("/").first
    Ability.new current_user, namespace
  end
end
