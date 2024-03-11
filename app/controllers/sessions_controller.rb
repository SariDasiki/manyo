class SessionsController < ApplicationController
    # before_action :correct_user, only: [:show, :edit]
    before_action :log_out_check, only: [:new]

    def new
        @user = User.new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user&.authenticate(params[:session][:password_digest])
          session[:user_id] = user.id
          log_in(user)
          flash[:success] = 'ログインしました'
          redirect_to tasks_path
        else
          flash.now[:danger] = 'メールアドレスまたはパスワードに誤りがあります'
          render :new
        end
      end

      def destroy
        session.delete(:user_id)
        flash[:notice] = 'ログアウトしました'
        redirect_to new_session_path
      end

      private 
      def user_params
        params.require(:user).permit(:name, :email, :password_digest, :password_confirmation)
      end

      def correct_user
        @user= User.find(params[:id])
        redirect_to current_user unless current_user?(@user)
      end
      
      def log_out_check
        if logged_in?
          flash[:notice] = 'ログアウトしてください'
          redirect_to tasks_path
        end
      end
end
