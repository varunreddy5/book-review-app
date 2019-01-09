class BooksController < ApplicationController
  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to(books_path)
    else
      render('new')
    end
  end

  def index
    @books = Book.order("created_at DESC")
  end

  def show
    if user_signed_in?
      @book = Book.find(params[:id])
    else
      redirect_to(new_user_registration_path)
    end
  end

  def edit
    if user_signed_in?
      @book = Book.find(params[:id])
    else
      redirect_to(new_user_registration_path)
    end
  end

  def update
    if user_signed_in?
      @book = Book.find(params[:id])
      if @book.update_attributes(book_params)
        redirect_to(book_path)
      else
        render('edit')
      end
    else
      redirect_to(new_user_registration_path)
    end
  end

  def delete
    if user_signed_in?
      @book = Book.find(params[:id])
    else
      redirect_to(new_user_registration_path)
    end
  end

  def destroy
    if user_signed_in?
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to(books_path)
    else
      redirect_to(new_user_registration_path)
    end

  end

  private
  def book_params
    params.require(:book).permit(:title, :description, :author)
  end

end
