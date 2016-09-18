class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = User.ransack params[:q]
    @users = @search.nil? ? User.all : @search.result
    @users = @users.order("updated_at DESC").paginate page: params[:page],
      per_page: Settings.size
  end

  def show
    @relationship = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
    @word_learned = Word.learned @user.id
    @activities = PublicActivity::Activity.order("created_at desc").where(
      owner_id: @user.id, owner_type: "User").
      paginate page: params[:page], per_page: Settings.size
  end

end
