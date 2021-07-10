class UsersController < ApplicationController
  # 
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    # ＠userが投稿したbookを表示する
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end
  
  # ===フォロー・フォロワー機能実装のため追加===
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
   # =============ここまで=============

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end