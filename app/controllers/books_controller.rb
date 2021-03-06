class BooksController < ApplicationController
  def new
    if user_signed_in?
      @book = current_user.books.build
      @categories = Category.all.map{|c|[c.name, c.id]}
    else
      redirect_to(new_user_registration_path)
    end
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
    if params[:category].blank?
      @books = Book.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @books = Book.where(:category_id => @category_id).order("created_at DESC")
    end
  end

  def show
      @book = Book.find(params[:id])
      if @book.reviews.blank?
        @average_review = 0
      else
        @average_review = @book.reviews.average(:rating).round(2)
      end
  end

  def edit
    if user_signed_in?
      @book = Book.find(params[:id])
      @categories = Category.all.map{|c|[c.name, c.id]}
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
    params.require(:book).permit(:title, :description, :author, :category_id, :avatar)
  end

end
