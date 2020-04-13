




class UsersController < ApplicationController
  before_action only: [:create, :edit, :update, :destroy, :new, :show]
    def show
        @user = User.find(params[:id])
    end
    def new
      @user = User.new
    end
  
    def create
        @user = User.new(user_params)
        if @user.save
          redirect_to user_path(@user.id)
        else
          render :new
        end
    end
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)  
        flash[:notice] = "ユーザー情報を編集しました"
        redirect_to user_path
      else
        render("users/edit")
      end
  end
    def edit
      @user = User.find(params[:id])
    end

    private
    
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :gazou, :gazou_cache)
    end
end
