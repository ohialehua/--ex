class SearchesController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    @word = params[:word]

    if @range == '1'
      @user = User.search(search,@word)
      @user.count
      if @user.count == 0
        render :search
      end
    else
      @book = Book.search(search,@word)
      @book.count
      if @book.count == 0
        render :search
      end
    end
  end

end