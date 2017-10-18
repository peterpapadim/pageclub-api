class Api::V1::BooksController < ApplicationController

  def create
    user = User.find(params[:user])
    user.books << Book.create(volume_id: params[:book])
  end

  def show
  end

  def update
  end

  def destroy
    user = User.find(params[:user])
    user.books.find_by(volume_id: params[:id]).destroy
  end

  def library
    all_books = []
    user = User.find(params[:id])
    books = user.books

    books.each do |book|
      book_result = RestClient.get "https://www.googleapis.com/books/v1/volumes?q=id:#{book.volume_id}&printType=books&maxResults=40&key=AIzaSyBrCZemnxLXIl3tV7ccNJp82SYvoSjmrFM"
      all_books << {book_info: JSON.parse(book_result.body)["items"][0], checked_out: book.checked_out, checked_out_user: book.checked_out_user}
    end
    render json: all_books
  end

  def search
    results = RestClient.get "https://www.googleapis.com/books/v1/volumes?q=#{params[:term]}&printType=books&maxResults=40&key=AIzaSyBrCZemnxLXIl3tV7ccNJp82SYvoSjmrFM"
    render json: results.body
  end

  def search_by_id
    results = RestClient.get "https://www.googleapis.com/books/v1/volumes?q=id:#{params[:term]}&printType=books&maxResults=40&key=AIzaSyBrCZemnxLXIl3tV7ccNJp82SYvoSjmrFM"
    render json: results.body
  end

end
