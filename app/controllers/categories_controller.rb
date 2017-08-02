class CategoriesController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  before_action :set_category, :only => [:update]

  def index
    @categories = current_user.categories.order(:name)
  end

  # update allows for shuffling & un-shuffling categories
  def update

    if @category.update_attributes(category_params)
      flash[:success] = "The #{@category.name} category has been #{@category.is_shuffled? ? 'shuffled' : 'un-shuffled'}!"
      redirect_to root_url
    else
      flash[:error] = "There was an issue #{@category.is_shuffled? ? 'un-shuffling' : 'shuffling'} the #{@category.name} category"
      redirect_to categories_path
    end

  end


  private

  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:is_shuffled)
  end

end