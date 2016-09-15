class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = User.ransack params[:q]
    @users = @search.nil? ? User.all : @search.result
    @users = @users.order("updated_at DESC").paginate page: params[:page],
      per_page: Settings.size
  end

  def show
    @word_learned = Word.learned @user.id
  end

end
