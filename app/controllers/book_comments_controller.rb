class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      redirect_to book_path(@book), notice: 'コメントを作成しました。'
    else
      redirect_to book_path(@book), alert: 'コメントの作成に失敗しました。'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = @book.book_comments.find(params[:id])
    @comment.destroy
    redirect_to book_path(@book), notice: 'コメントを削除しました。'
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def correct_user
    @comment = current_user.book_comments.find_by(id: params[:id])
    redirect_to root_path, alert: '権限がありません。' if @comment.nil?
  end
end
