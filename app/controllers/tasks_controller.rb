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
      @tasks = Task.all

      if params[:search].present?
        if params[:search][:title].present? && params[:search][:status].present?
          @tasks = @tasks.title_like(params[:search][:title]).status_search(params[:search][:status])
          # @tasks = titleのあいまい検索のscopeとstatus_searchを.で繋げて使う notion 万葉課題3 ヒント1
        elsif params[:search][:title].present?
          @tasks = @tasks.title_like(params[:search][:title])
        elsif params[:search][:status].present?
          @tasks = @tasks.status_search(params[:search][:status])
        end
      end

      # 終了期限をクリックしたら終了期限の昇順でソート
      # Parameters: {"sort_deadline_on"=>"true"}
      @tasks = @tasks.sort_deadline_on(params[:sort_deadline_on])
      # 優先度をクリックしたら優先度の高い順にソート
      # Parameters: {"sort_priority"=>"true"}
      @tasks = @tasks.sort_priority(params[:sort_priority])

      @tasks = @tasks.order(created_at: "DESC")
                   .page(params[:page]).per(10)
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
      params.require(:task).permit(:title, :content, :page, :status, :priority, :deadline_on)
    end
end
