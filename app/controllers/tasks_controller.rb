class TasksController < ApplicationController
    def index
        @show_tasks = current_user.categories.find(params[:category_id]).tasks
        @category = current_user.categories.find(params[:category_id])
        @build_task = current_user.categories.find(params[:category_id]).tasks.build
        render "task/index"
    end

    def create
        @create_task = current_user.categories.find(params[:category_id]).tasks.build(task_params)
        if @create_task.save
            flash.notice = "Task created"
        else
            flash.notice = "Task name can't be blank"
        end
        redirect_to category_tasks_path(params[:category_id])
    end

    def edit
        @to_be_updated = current_user.categories.find(params[:category_id]).tasks.find(params[:id])
        render "task/edit"
    end

    def update
        current_user.categories.find(params[:category_id]).tasks.find(params[:id]).update(task_params)
        flash.notice = "Task updated"
        redirect_to category_tasks_path
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
