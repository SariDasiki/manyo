class UsersController < ApplicationController
  before_action :log_in_check, only: [:show, :edit, :update, :destroy]
  before_action :log_out_check, only: [:new]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:notice] ='アカウントを登録しました'
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:notice] = 'アクセス権限がありません'
      redirect_to tasks_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'アカウントを更新しました'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.delete
    flash[:notice] = 'ユーザを削除しました'
    redirect_to users_path
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
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

    def log_out_check
      if logged_in?
        flash[:notice] = 'ログアウトしてください'
        redirect_to tasks_path
      end  
    end

end
