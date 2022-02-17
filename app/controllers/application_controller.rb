class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
  
  
  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
    end
    
    def after_sign_in_path_for(resource)
      flash[:notice] = "Welcome! You have signed up successfully."
      user_path(current_user)
    end
    
    def after_sign_out_path_for(resource)
      root_path
    end
    
    def correct_user
      @book = Book.find(params[:id])
      @user = @book.user
      redirect_to(books_path) unless @user == current_user
    end
    
end
