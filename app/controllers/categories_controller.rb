class CategoriesController < ApplicationController
    def create
        @create_category = current_user.categories.build(category_params)
        if @create_category.save
            flash.notice = "Category created"
        else
            @error = @create_category.errors.full_messages.first
            if @error.include? "blank"
                flash.notice = "Category name can't be blank"
            else
                flash.notice = "Category name is redundant"
            end
        end
        redirect_to :root 
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
        @update_category = current_user.categories.find(params[:id])
        if @update_category.update(category_params)
            flash.notice = "Category updated"
            redirect_to :root 
        else
            @error = @update_category.errors.full_messages.first
            if @error.include? "blank"
                flash.notice = "Category name can't be blank"
            else
                flash.notice = "Category name is redundant"
            end
            redirect_to edit_category_path(params[:id])
        end
    end

    private
    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name,:user_id)
    end
end