class LabelsController < ApplicationController
before_action :log_in_check

  def new
    @label = Label.new
  end
 
  def create
    @label = current_user.labels.build(label_params)
    
     if @label.save
       flash[:notice] ='ラベルを登録しました'
       redirect_to labels_path
     else
       render :new
     end
  end

  def index
    @labels = Label.eager_load(:tasks)
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      flash[:notice] = 'ラベルを更新しました'
      redirect_to labels_path
    else
      render :edit
    end
  end

  def destroy
    @label = Label.find(params[:id])
    if @label.destroy
      flash[:notice] = 'ラベルを削除しました'
      redirect_to labels_path
    end   
  end
  
  private 
    def label_params
      params.require(:label).permit(
        :name, :user_id)
    end

    def correct_user
      @user= User.find(params[:id])
      redirect_to current_user unless current_user?(@user)
    end
    
    def log_in_check
      unless logged_in?
        flash[:notice] = 'ログインしてください'
        redirect_to new_session_path
      end
 end
end
