class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :show, :following, :followers]
  
  def index
    @users = User.all
  end
  
  def show
    @book = Book.new
    @books = @user.books # ユーザーの本のリストを取得
  end

  def edit
    unless @user == current_user
      redirect_to user_path(current_user), alert: "You can only edit your own profile."
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def following
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @users = @user.followers
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :profile_image)
  end
end
