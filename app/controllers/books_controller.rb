class BooksController < ApplicationController

def index
  @book = Book.new
  @books = Book.all.order(created_at: :asc)
end

def create
  @book = Book.new(book_params)  
  if @book.save
    flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book.id)
  else
    @books = Book.all.order(created_at: :asc)
    render :index
  end
end

def show
@book = Book.find(params[:id])
end

def edit  
@book = Book.find(params[:id])
end

def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book.id)
  else
    flash.now[:alert] = "Update failed. Please check the errors."
    flash.now[:alert] = @book.errors.full_messages.join(', ')
    render :edit
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

end