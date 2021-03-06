class TasksController < ApplicationController
    def index
        if params[:format]== "yes"
            @show_tasks = current_user.categories.find(params[:category_id]).tasks.basic_search(params[:query])
        else
            @show_tasks = current_user.categories.find(params[:category_id]).tasks
        end
        @category = current_user.categories.find(params[:category_id])
        @build_task = current_user.categories.find(params[:category_id]).tasks.build
        render "task/index"
    end

    def create
        @create_task = current_user.categories.find(params[:category_id]).tasks.build(task_params)
        if @create_task.save
            flash.notice = "Task created"
        else
            @error = @create_task.errors.full_messages.first
            if @error.include? "blank"
                flash.notice = "Task name can't be blank"
            else
                flash.notice = "Task name is redundant"
            end
        end
        redirect_to category_tasks_path(params[:category_id])
    end

    def edit
        @to_be_updated = current_user.categories.find(params[:category_id]).tasks.find(params[:id])
        render "task/edit"
    end

    def update
        @update_task = current_user.categories.find(params[:category_id]).tasks.find(params[:id])
        if @update_task.update(task_params)
            flash.notice = "Category updated"
            redirect_to category_tasks_path
        else
            @error = @update_task.errors.full_messages.first
            if @error.include? "blank"
                flash.notice = "Task name can't be blank"
            else
                flash.notice = "Task name is redundant"
            end
            redirect_to edit_category_task_path(params[:category_id],params[:id])
        end
    end

    def destroy
        @to_be_deleted = current_user.categories.find(params[:category_id]).tasks.find(params[:id])
        @to_be_deleted.destroy
        flash.notice = "Task finished"
        redirect_to category_tasks_path
    end

    private
    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name,:category_id)
    end
end
