class Api::V1::BooksController < ApplicationController

  def search
    results = RestClient.get "https://www.googleapis.com/books/v1/volumes?q=#{params[:term]}&printType=books&maxResults=40&key=AIzaSyBrCZemnxLXIl3tV7ccNJp82SYvoSjmrFM"
    render json: results.body
  end

  def isbn
    results = RestClient.get "https://www.googleapis.com/books/v1/volumes?q=isbn:#{params[:term]}&printType=books&maxResults=40&key=AIzaSyBrCZemnxLXIl3tV7ccNJp82SYvoSjmrFM"
    render json: results.body
  end

end
