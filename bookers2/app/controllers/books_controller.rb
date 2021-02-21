class BooksController < ApplicationController
  # before_action :authenticate_user!　（開発の途中で入力していた。質問したい）
  before_action :ensure_correct_user, {only:[:edit,:update,:destroy]}

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.new
    @bookpost = Book.find(params[:id])
    @user = User.find(@bookpost.user.id)
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user=current_user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render("books/index")
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render("books/edit")
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      flash[:notice] = "※権限がありません"
      redirect_to books_path
    end
  end

end