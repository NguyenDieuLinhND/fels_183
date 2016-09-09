class Admin::CategoriesController < Admin::BaseController
  load_and_authorize_resource

  def index
    @search = Category.ransack params[:q]
    @categories = @search.nil? ? Category.all : @search.result
    @categories = @categories.order("updated_at DESC").paginate page: params[:page],
      per_page: Settings.size
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flash.create_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @category.update_attributes category_params
        format.html {redirect_to admin_categories_path,
          notice: t("flash.edit_success")}
        format.js
      else
        format.html {render :edit}
        format.js
      end
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
