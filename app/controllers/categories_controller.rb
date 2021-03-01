class CategoriesController < ApplicationController
    def create
        @create_category = current_user.categories.build(category_params)
        if @create_category.save
            render "home/temp"
    end

end

private
    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name,:user_id)
    end
end