class TasksController < ApplicationController
    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_params)
      if @task.save
       flash[:notice] ='タスクを登録しました'
       redirect_to tasks_path
      else
        render :new
      end
    end

    def index
      @tasks = Task.order(created_at: "DESC").page(params[:page])
      .per(10)
    end

    def show
      @task = Task.find(params[:id])
    end

    def edit
      @task = Task.find(params[:id])
    end

    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        flash[:notice] = 'タスクを更新しました'
        redirect_to task_path(@task)
      else
        render :edit
      end
    end

    def destroy
      @task = Task.find(params[:id])
      @task.delete
      flash[:notice] = 'タスクを削除しました'
      redirect_to tasks_path
    end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :page)
    end
    
end
