# app/controllers/books_controller.rb
class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def show
    @user = @book.user
    @average_rating = @book.ratings.average(:value).to_f.round(2)
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      if params[:book][:rating].present?
        @book.ratings.create(user: current_user, value: params[:book][:rating])
      end
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  def top_liked
    @books = Book.joins(:favorites)
                 .where(favorites: { created_at: 1.week.ago..Time.current })
                 .group('books.id')
                 .order('COUNT(favorites.id) DESC')
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body, :rating)
  end
end
