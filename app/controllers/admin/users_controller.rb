class Admin::UsersController < ApplicationController
  before_action :log_in_check
  before_action :user_admin_check

  def new
    @user = User.new
  end

  def index
    @users = User.eager_load(:tasks)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] ='ユーザーを登録しました'
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'ユーザを更新しました'
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'ユーザーを削除しました'
      redirect_to admin_users_path
    else
      @users = User.all
      render :index
    end
      
  end

  private 
    def user_params
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation, :admin
      )
    end

    def correct_user
      @user= User.find(params[:id])
      redirect_to current_user unless current_user?(@user)
    end

    def user_admin_check
      if current_user.admin == false
        flash[:notice] = "管理者以外アクセスできません"
        redirect_to tasks_path
      end
    end

    def log_in_check
      unless logged_in?
        flash[:notice] = 'ログインしてください'
        redirect_to new_session_path
      end
    end


end

