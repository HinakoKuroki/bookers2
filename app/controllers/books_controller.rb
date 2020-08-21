class BooksController < ApplicationController

    before_action :authenticate_user!
    before_action :correct_user,   only: [:edit, :update, :destroy]

    def index
      @books = Book.all
      @book = Book.new
      @user = current_user
    end
  
    def create
      @book = Book.new(book_params)
      @book.user = current_user
      if @book.save
        redirect_to book_path(@book), notice: 'Book was successfully created.'
      else
        @books = Book.all
        @user = current_user
        render 'users/show'
      end
    end
  
    def show
      @book = Book.find(params[:id])
      @newbook = Book.new
    end
  
    def edit
      @book = Book.find(params[:id])
    end
  
    def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
        redirect_to book_path(@book), notice: 'Book was successfully updated.'
      else
        render 'edit'
      end
    end
  
    def destroy
      blog = Book.find(params[:id])
      blog.destroy
      redirect_to books_path
    end
  
    
  
  
    private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def correct_user
      @user = Book.find(params[:id]).user
      redirect_to(books_path) unless @user == current_user
  end
end
