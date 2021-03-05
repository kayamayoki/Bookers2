class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])

  end

  def following
    @title ="Following"
    @user = User.find(params[:id])
    @users = @user.follower
    @following_count = Relationship.all.count(:followed_id)
    @followers_count = Relationship.all.count(:follower_id)
    render 'show_follower'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followed
    @following_count = Relationship.all.count(:followed_id)
    @followers_count = Relationship.all.count(:follower_id)
    render 'show_followed'
  end

  def update
    @books = Book.all
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
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
