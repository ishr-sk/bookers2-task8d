class SearchesController < ApplicationController
  def search
    @category = params[:category]
    search = params[:search]
    word = params[:word]

    if @category == "1"
      @user = User.search(search, word)
    else
      @book = Book.search(search, word)
    end
  end
end
