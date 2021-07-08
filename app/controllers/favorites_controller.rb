class FavoritesController < ApplicationController
  # jsファイルの変数と一緒のものを定義する（＠book）
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # 非同期通信化のため下記削除
    #redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # 非同期通信化のため下記削除
    #redirect_back(fallback_location: root_path)
  end


end
