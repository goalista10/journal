class CategoriesController < ApplicationController
    def create
        @create_category = current_user.categories.build(category_params)
        if @create_category.save
            flash.notice = "Category created"
            redirect_to :root 
        end
    end

    def destroy
        @to_be_deleted = current_user.categories.find(params[:id])
        @to_be_deleted.destroy
        flash.notice = "Category deleted"
        redirect_to :root 
    end

    def edit
        @to_be_updated = current_user.categories.find(params[:id])
        render "home/edit"
    end

    def update
        current_user.categories.find(params[:id]).update(category_params)
        flash.notice = "Category updated"
        redirect_to :root 
    end

    private
    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name,:user_id)
    end
end