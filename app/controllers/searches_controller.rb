class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @search_method = params[:search_method]

    if @range == "User"
      @users = search_users(@word, @search_method)
    else
      @books = search_books(@word, @search_method)
    end
  end

  private

  def search_users(word, search_method)
    case search_method
    when 'exact'
      User.where(name: word)
    when 'forward'
      User.where('name LIKE ?', "#{word}%")
    when 'backward'
      User.where('name LIKE ?', "%#{word}")
    when 'partial'
      User.where('name LIKE ?', "%#{word}%")
    else
      User.none
    end
  end

  def search_books(word, search_method)
    case search_method
    when 'exact'
      Book.where(title: word)
    when 'forward'
      Book.where('title LIKE ?', "#{word}%")
    when 'backward'
      Book.where('title LIKE ?', "%#{word}")
    when 'partial'
      Book.where('title LIKE ?', "%#{word}%")
    else
      Book.none
    end
  end
end