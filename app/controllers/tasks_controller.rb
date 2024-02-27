class TasksController < ApplicationController
    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_params)
      if @task.save
       flash[:notice] ='Task was successfully created.'
       redirect_to tasks_path
      else
        render :new
      end
    end

    def index
      @tasks = Task.all
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
        flash[:notice] = 'Task was successfully updated.'
        redirect_to task_path(@task)
      else
        render :edit
      end
    end

    def destroy
      @task = Task.find(params[:id])
      @task.delete
      flash[:notice] = 'Task was successfully destroyed.'
      redirect_to tasks_path
    end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content)
    end
    
end